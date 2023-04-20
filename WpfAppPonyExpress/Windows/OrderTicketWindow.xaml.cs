using Microsoft.Win32;
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
using System.Windows.Shapes;
using Word = Microsoft.Office.Interop.Word;
using WpfAppPonyExpress.Models;

namespace WpfAppPonyExpress.Windows
{
    /// <summary>
    /// Логика взаимодействия для OrderTicketWindow.xaml
    /// </summary>
    
        public partial class OrderTicketWindow : Window
        {

            Order _currentOrder; // текущий заказ
            User _currentUser;// текущий пользователь
            public OrderTicketWindow(Order order)
            {
                InitializeComponent();
                LoadDataAndInit(order);
            }
            // Загрузка и инициализация данных
            void LoadDataAndInit(Order order)
            {
                _currentOrder = order;

                _currentUser = Manager.CurrentUser;
                if (_currentUser != null)
                {
                TextBlockOrderNumber.Text = $"Заказ №{_currentOrder.OrderID} на имя " +
                    $"{ _currentUser.Clients.SingleOrDefault().GetFio} оформлен";
                }
                else
                { 
                    TextBlockOrderNumber.Text = $"Заказ №{_currentOrder.OrderID} оформлен"; 
                }
                TextBlockTotalCost.Text = $"Итого {_currentOrder.Rate.Price:C}";
                TextBlockOrderCreateDate.Text = _currentOrder.OrderCreateDate.ToLongDateString();
                TextBlockOrderDeliveryDate.Text = _currentOrder.OrderDeliveryDate.ToLongDateString();
                TextBlockOrderGetCode.Text = _currentOrder.GetCode.ToString();
                TextBlockPickupPoint.Text = _currentOrder.PickupPoint.Address;
            }

            private void BtnOk_Click(object sender, RoutedEventArgs e)
            {
                this.Close();
            }

            private void BtnSavePDF_Click(object sender, RoutedEventArgs e)
            {
                PrintInPdf(_currentOrder);
            }

            void PrintInPdf(Order order)
            {
                try
                {
                    string path = null;
                    // указываем файл для сохранения
                    SaveFileDialog saveFileDialog = new SaveFileDialog();
                    saveFileDialog.Filter = "PDF (.pdf)|*.pdf"; // Filter files by extension
                                                                // если диалог завершился успешно
                    if (saveFileDialog.ShowDialog() == true)
                    {
                        path = saveFileDialog.FileName;
                        Word.Application application = new Word.Application();
                        Word.Document document = application.Documents.Add();
                        Word.Paragraph paragraph = document.Paragraphs.Add();
                        Word.Range range = paragraph.Range;
                        range.Font.Bold = 1;
                        range.Text = $"Номер заказа: {order.OrderID}";
                        range.InsertParagraphAfter();

                        range = paragraph.Range;
                        range.Font.Bold = 0;
                        range.Text = $"Дата заказа: {order.OrderCreateDate}\n" +
                            $"Дата получения заказа: {order.OrderDeliveryDate}\n" +
                            $"Пункт выдачи: {order.PickupPoint.Address}";
                        range.InsertParagraphAfter();

                        range = paragraph.Range;
                        range.Font.Bold = 1;
                        range.Text = $"Код получения: {order.GetCode}";
                        range.InsertParagraphAfter();
                        range.Font.Bold = 0;

                       
                        Word.Paragraph generalSumProduct = document.Paragraphs.Add();
                        Word.Range generalRange = generalSumProduct.Range;
                        generalRange.Text = $"\nОбщая стоимость заказа: {order.Rate.Price:f2} руб.";
                        document.SaveAs2($@"{path}", Word.WdExportFormat.wdExportFormatPDF);
                        MessageBox.Show("Талон сохранен");
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }

            }
            // отображение номеров строк в DataGrid
            private void DataGridGoodLoadingRow(object sender, DataGridRowEventArgs e)
            {
                e.Row.Header = (e.Row.GetIndex() + 1).ToString();
            }
        }
    }
