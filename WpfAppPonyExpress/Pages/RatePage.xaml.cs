using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System;
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
using WpfAppPonyExpress.Windows;
using System.Data.Entity;

namespace WpfAppPonyExpress.Pages
{
    /// <summary>
    /// Логика взаимодействия для RatePage.xaml
    /// </summary>
    public partial class RatePage : Page
    {
        List<Rate> rates;
        int _itemcount = 0;
        public RatePage()
        {
            InitializeComponent();
            // загрузка данных в combobox + добавление дополнительной строки

        }
        private void ButtonClick(object sender, RoutedEventArgs e)
        {
            // открытие редактирования товара
            // передача выбранного товара в AddRatePage
            // Manager.MainFrame.Navigate(new AddRatePage((sender as Button).DataContext as Rate));

            try
            {
                // если ни одного объекта не выделено, выходим
                if (DataGridRate.SelectedItem == null) return;
                // получаем выделенный объект
                Rate selected = (sender as Button).DataContext as Rate;

                MessageBox.Show(selected.Service.Name);
                RateWindow window = new RateWindow(selected);
             
                if (window.ShowDialog() == true)
                {
                    if (window.currentItem != null)
                    {
                        DataDBEntities.GetContext().Entry(window.currentItem).State = EntityState.Modified;
                        DataDBEntities.GetContext().SaveChanges();
                        LoadData();
                        MessageBox.Show("Запись изменена", "Внимание", MessageBoxButton.OK, MessageBoxImage.Information);
                    }
                }
            }
            catch
            {
                MessageBox.Show("Ошибка");
            }

        }

        private void PageIsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            //событие отображения данного Page
            // обновляем данные каждый раз когда активируется этот Page
            if (Visibility == Visibility.Visible)
            {
                DataGridRate.ItemsSource = null;
                //загрузка обновленных данных
                var services = DataDBEntities.GetContext().Services.OrderBy(p => p.Name).ToList();
                services.Insert(0, new Service
                {
                    Name = "Все типы"
                }
                );
                ComboService.ItemsSource = services;
                ComboService.SelectedIndex = 0;

                var zones = DataDBEntities.GetContext().Zones.OrderBy(p => p.Name).ToList();
                zones.Insert(0, new Zone
                {
                    Name = "Все типы"
                }
                );
                ComboZone.ItemsSource = zones;
                ComboZone.SelectedIndex = 0;
                DataDBEntities.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                rates = DataDBEntities.GetContext().Rates.OrderBy(p => p.Service.Name).OrderBy(p => p.Zone.Name).ToList();
                DataGridRate.ItemsSource = rates;
                _itemcount = rates.Count;
                TextBlockCount.Text = $" Результат запроса: {_itemcount} записей из {_itemcount}";
            }
        }

        void LoadData()
        {
            DataDBEntities.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
            rates = DataDBEntities.GetContext().Rates.Include(p => p.Service).Include(p => p.Zone).OrderBy(p => p.Service.Name).OrderBy(p => p.Zone.Name).ToList();
            DataGridRate.ItemsSource = rates;
            _itemcount = rates.Count;
            TextBlockCount.Text = $" Результат запроса: {_itemcount} записей из {_itemcount}";
        }
        // Поиск товаров, которые содержат данную поисковую строку
        
        // Поиск товаров конкретного производителя
        private void ComboTypeSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateData();
        }
        /// <summary>
        /// Метод для фильтрации и сортировки данных
        /// </summary>
        private void UpdateData()
        {
            // получаем текущие данные из бд
            var currentRates = DataDBEntities.GetContext().Rates.OrderBy(p => p.Service.Name).OrderBy(p => p.Zone.Name).ToList();
            // выбор только тех товаров, которые принадлежат данному производителю
            if (ComboService.SelectedIndex > 0)
                currentRates = currentRates.Where(p => p.ServiceId == (ComboService.SelectedItem as Service).ServiceId).ToList();
            if (ComboZone.SelectedIndex > 0)
                currentRates = currentRates.Where(p => p.ZoneId == (ComboZone.SelectedItem as Zone).ZoneID).ToList();
            // выбор тех товаров, в названии которых есть поисковая строка
         //   currentRates = currentRates.Where(p => p.RateName.ToLower().Contains(TBoxSearch.Text.ToLower())).ToList();

            // сортировка
            if (ComboSort.SelectedIndex >= 0)
            {
                // сортировка по возрастанию цены
                if (ComboSort.SelectedIndex == 0)
                    currentRates = currentRates.OrderBy(p => p.Price).ToList();
                // сортировка по убыванию цены
                if (ComboSort.SelectedIndex == 1)
                    currentRates = currentRates.OrderByDescending(p => p.Price).ToList();
            }
            // В качестве источника данных присваиваем список данных
            rates = currentRates;
            DataGridRate.ItemsSource = currentRates;
            // отображение количества записей
            TextBlockCount.Text = $" Результат запроса: {currentRates.Count} записей из {_itemcount}";
        }
        // сортировка товаров 
        private void ComboSortSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateData();
        }
        private void BtnAddClick(object sender, RoutedEventArgs e)
        {
            // открытие  AddRatePage для добавления новой записи
            //Manager.MainFrame.Navigate(new AddRatePage(null));

            try
            {

                RateWindow window = new RateWindow(new Rate());
                if (window.ShowDialog() == true)
                {
                    DataDBEntities.GetContext().Rates.Add(window.currentItem);
                    DataDBEntities.GetContext().SaveChanges();
                    LoadData();
                    MessageBox.Show("Запись добавлена", "Внимание", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            catch
            {
                MessageBox.Show("Ошибка");
            }
        }

        private void BtnDeleteClick(object sender, RoutedEventArgs e)
        {
            // удаление выбранного товара из таблицы
            //получаем все выделенные товары
            var selectedRates = DataGridRate.SelectedItems.Cast<Rate>().ToList();
            // вывод сообщения с вопросом Удалить запись?
            MessageBoxResult messageBoxResult = MessageBox.Show($"Удалить {selectedRates.Count()} записей???",
                "Удаление", MessageBoxButton.OKCancel, MessageBoxImage.Question);
            //если пользователь нажал ОК пытаемся удалить запись
            if (messageBoxResult == MessageBoxResult.OK)
            {
                try
                {
                    // берем из списка удаляемых товаров один элемент
                    Rate x = selectedRates[0];
                    // проверка, есть ли у товара в таблице о продажах связанные записи
                    // если да, то выбрасывается исключение и удаление прерывается
                    if (x.Orders.Count > 0)
                        throw new Exception("Есть записи в продажах");
                   
                    // удаляем товара
                    DataDBEntities.GetContext().Rates.Remove(x);
                    //сохраняем изменения
                    DataDBEntities.GetContext().SaveChanges();
                    MessageBox.Show("Записи удалены");
                    rates.Clear();
                    rates = DataDBEntities.GetContext().Rates.OrderBy(p => p.Service.Name).OrderBy(p => p.Zone.Name).ToList();
                    DataGridRate.ItemsSource = null;
                    DataGridRate.ItemsSource = rates;
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString(), "Ошибка удаления", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }
        private void BtnSellClick(object sender, RoutedEventArgs e)
        {
            // открытие страницы о продажах SellRatesPage
            // передача в него выбранного товара
           // Manager.MainFrame.Navigate(new SellRatesPage((sender as Button).DataContext as Rate));
        }
        // отображение номеров строк в DataGrid
        private void DataGridRateLoadingRow(object sender, DataGridRowEventArgs e)
        {
            e.Row.Header = (e.Row.GetIndex() + 1).ToString();
        }
        private void BtnEditDev_Click(object sender, RoutedEventArgs e)
        {
           // Manager.MainFrame.Navigate(new DevelopersPage());
        }

        private void PrintExcel()
        {
            //string fileName = AppDomain.CurrentDomain.BaseDirectory + "\\" + "Rates" + ".xltx";
            //Excel.Application xlApp = new Excel.Application();
            //Excel.Worksheet xlSheet = new Excel.Worksheet();
            //try
            //{
            //    //добавляем книгу
            //    xlApp.Workbooks.Open(fileName, Type.Missing, Type.Missing, Type.Missing, Type.Missing,
            //                              Type.Missing, Type.Missing, Type.Missing, Type.Missing,
            //                              Type.Missing, Type.Missing, Type.Missing, Type.Missing,
            //                              Type.Missing, Type.Missing);
            //    //делаем временно неактивным документ
            //    xlApp.Interactive = false;
            //    xlApp.EnableEvents = false;
            //    Excel.Range xlSheetRange;
            //    //выбираем лист на котором будем работать (Лист 1)
            //    xlSheet = (Excel.Worksheet)xlApp.Sheets[1];
            //    //Название листа
            //    xlSheet.Name = "Список товаров";
            //    int row = 2;
            //    int i = 0;


            //    foreach (Rate good in rates)
            //    {
            //        xlSheet.Cells[row, 1] = (i + 1).ToString();
            //        string s;
            //        // DateTime y = Convert.ToDateTime(dtOrders.Rows[i].Cells[1].Value);
            //        xlSheet.Cells[row, 2] = good.RateId.ToString();
            //        s = "";


            //        xlSheet.Cells[row, 3] = good.RateName.ToString();
            //        xlSheet.Cells[row, 4] = good.Price.ToString();
            //        s = "";
            //        if (good.Weight != null) s = good.Weight.ToString();
            //        xlSheet.Cells[row, 5] = s;
            //        s = "";
            //        if (good.Width != null) s = good.Width.ToString();
            //        xlSheet.Cells[row, 6] = s;
            //        s = "";
            //        if (good.Length != null) s = good.Length.ToString();
            //        xlSheet.Cells[row, 7] = s;
            //        s = "";
            //        if (good.Heigth != null) s = good.Heigth.ToString();
            //        xlSheet.Cells[row, 8] = s;

            //        xlSheet.Cells[row, 9] = good.Developer.DeveloperName;
            //        xlSheet.Cells[row, 10] = good.GetStatus;
            //        row++;
            //        Excel.Range r = xlSheet.get_Range("A" + row.ToString(), "J" + row.ToString());
            //        r.Insert(Excel.XlInsertShiftDirection.xlShiftDown);
            //        i++;
            //    }




            //    row--;
            //    xlSheetRange = xlSheet.get_Range("A2:J" + (row + 1).ToString(), Type.Missing);
            //    xlSheetRange.Borders.LineStyle = true;
            //    //xlSheet.Cells[row + 1, 9] = "=SUM(I2:I" + row.ToString() + ")";

            //    //xlSheet.Cells[row + 1, 8] = "ИТОГО:";
            //    row++;

            //    //выбираем всю область данных*/
            //    xlSheetRange = xlSheet.UsedRange;
            //    //выравниваем строки и колонки по их содержимому
            //    xlSheetRange.Columns.AutoFit();
            //    xlSheetRange.Rows.AutoFit();
            //}
            //catch (Exception ex)
            //{
            //    MessageBox.Show(ex.ToString());
            //}
            //finally
            //{
            //    //Показываем ексель
            //    xlApp.Visible = true;
            //    xlApp.Interactive = true;
            //    xlApp.ScreenUpdating = true;
            //    xlApp.UserControl = true;
            //}
        }


        private void BtnExcel_Click(object sender, RoutedEventArgs e)
        {
            PrintExcel();
        }

        private void ComboZone_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateData();
        }

        private void ComboService_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateData();
        }
    }
}
