﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using WpfAppPonyExpress.Models;
using Excel = Microsoft.Office.Interop.Excel;

namespace WpfAppPonyExpress.Pages
{
    /// <summary>
    /// Логика взаимодействия для OrdersPage.xaml
    /// </summary>
    public partial class OrdersPage : Page
    {
        int _itemcount = 0; // 
        List<Order> orders;

        public OrdersPage()
        {
            InitializeComponent();
            LoadAndInitData();
        }
        void LoadAndInitData()
        {
            var statuses = DataDBEntities.GetContext().OrderStatus.OrderBy(p => p.Name).ToList();
            statuses.Insert(0, new OrderStatu
            {
                Name = "Все типы"
            }
            );
            ComboStatus.ItemsSource = statuses;
            ComboStatus.SelectedIndex = 0;
        }


        private void UpdateData()
        {
            // получаем текущие данные из бд
            var currentData = DataDBEntities.GetContext().Orders.OrderBy(p => p.OrderID).ToList();
            if (ComboStatus.SelectedIndex > 0)
                currentData = currentData.Where(p => p.OrderStatusID == (ComboStatus.SelectedItem as OrderStatu).Id).ToList();
            // выбор тех товаров, в названии которых есть поисковая строка
            currentData = currentData.Where(p => p.OrderID.ToString().ToLower().Contains(TBoxSearch.Text.ToLower())).ToList();

            // сортировка
            if (ComboSort.SelectedIndex >= 0)
            {
                // сортировка по возрастанию цены
                if (ComboSort.SelectedIndex == 0)
                    currentData = currentData.OrderBy(p => p.OrderCreateDate).ToList();
                // сортировка по убыванию цены
                if (ComboSort.SelectedIndex == 1)
                    currentData = currentData.OrderByDescending(p => p.OrderCreateDate).ToList();
            }
            // В качестве источника данных присваиваем список данных
            DataGridOrders.ItemsSource = currentData;
            orders = currentData;
            // отображение количества записей
            TextBlockCount.Text = $" Результат запроса: {currentData.Count} записей из {_itemcount}";
        }


        private void ComboStatus_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateData();
        }

        private void ComboSort_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateData();
        }

        private void TBoxSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateData();
        }

      
        private void PageIsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            //обновление данных после каждой активации окна
            if (Visibility == Visibility.Visible)
            {
                LoadOrders();
            }
        }


        void LoadOrders()
        {
            DataDBEntities.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());

            var currentData = DataDBEntities.GetContext().Orders.OrderBy(p => p.OrderID).ToList();
            DataGridOrders.ItemsSource = currentData;
            _itemcount = DataGridOrders.Items.Count;
            orders = currentData;
            TextBlockCount.Text = $" Результат запроса: {_itemcount} записей из {_itemcount}";
        }

        private void BtnExcel_Click(object sender, RoutedEventArgs e)
        {
            PrintExcel();
        }
        private void DataGridGoodLoadingRow(object sender, DataGridRowEventArgs e)
        {
            e.Row.Header = (e.Row.GetIndex() + 1).ToString();
        }

        private void PrintExcel()
        {
            string fileName = AppDomain.CurrentDomain.BaseDirectory + "\\" + "Orders" + ".xltx";
            Excel.Application xlApp = new Excel.Application();
            Excel.Worksheet xlSheet = new Excel.Worksheet();
            try
            {
                //добавляем книгу
                xlApp.Workbooks.Open(fileName, System.Type.Missing, System.Type.Missing, System.Type.Missing, System.Type.Missing,
                                          System.Type.Missing, System.Type.Missing, System.Type.Missing, System.Type.Missing,
                                          System.Type.Missing, System.Type.Missing, System.Type.Missing, System.Type.Missing,
                                          System.Type.Missing, System.Type.Missing);
                //делаем временно неактивным документ
                xlApp.Interactive = false;
                xlApp.EnableEvents = false;
                Excel.Range xlSheetRange;
                //выбираем лист на котором будем работать (Лист 1)
                xlSheet = (Excel.Worksheet)xlApp.Sheets[1];
                //Название листа
                xlSheet.Name = "Список товаров";
                int row = 2;
                int i = 0;


                foreach (Order order in orders)
                {
                    xlSheet.Cells[row, 1] = (i + 1).ToString();
                    string s;
                    // DateTime y = Convert.ToDateTime(dtOrders.Rows[i].Cells[1].Value);
                    xlSheet.Cells[row, 2] = order.OrderID.ToString();
                    xlSheet.Cells[row, 3] = order.User.Clients.Single().GetFio;
                    xlSheet.Cells[row, 4] = order.Rate.Price.ToString();
                    xlSheet.Cells[row, 5] = order.OrderStatu.Name;
                    xlSheet.Cells[row, 6] = order.OrderCreateDate.ToShortDateString();
                    xlSheet.Cells[row, 7] = order.OrderDeliveryDate.ToShortDateString();
                    xlSheet.Cells[row, 8] = order.PickupPoint.Address;
                    xlSheet.Cells[row, 9] = order.Weight.ToString();
                    xlSheet.Cells[row, 10] = order.Rate.Zone.Name;

                    row++;
                    Excel.Range r = xlSheet.get_Range("A" + row.ToString(), "J" + row.ToString());
                    r.Insert(Excel.XlInsertShiftDirection.xlShiftDown);
                    i++;
                }




                row--;
                xlSheetRange = xlSheet.get_Range("A2:J" + (row + 1).ToString(), System.Type.Missing);
                xlSheetRange.Borders.LineStyle = true;
                //xlSheet.Cells[row + 1, 9] = "=SUM(I2:I" + row.ToString() + ")";

                //xlSheet.Cells[row + 1, 8] = "ИТОГО:";
                row++;

                //выбираем всю область данных*/
                xlSheetRange = xlSheet.UsedRange;
                //выравниваем строки и колонки по их содержимому
                xlSheetRange.Columns.AutoFit();
                xlSheetRange.Rows.AutoFit();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
            finally
            {
                //Показываем ексель
                xlApp.Visible = true;
                xlApp.Interactive = true;
                xlApp.ScreenUpdating = true;
                xlApp.UserControl = true;
            }
        }
    }
}