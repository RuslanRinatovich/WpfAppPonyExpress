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

namespace WpfAppPonyExpress.Pages
{
    /// <summary>
    /// Логика взаимодействия для AddOrderPage.xaml
    /// </summary>
    public partial class AddOrderPage : Page
    {
        Order _currentOrder;
        User _currentUser;

        public AddOrderPage()
        {
            InitializeComponent();
            LoadDataAndInit();
        }

        /// <summary>
        /// Загрузка и инициализация полей
        /// </summary>
        void LoadDataAndInit()
        {
            
            _currentOrder = CreateNewOrder();
            // текущий пользователь
            _currentUser = Manager.CurrentUser;
            if (_currentUser != null)
            {
                TextBlockOrderNumber.Text = $"Заказ №{_currentOrder.OrderID} на имя " +
                    $"{ _currentUser.Clients.SingleOrDefault().GetFio}";
            }
            else
            {
                TextBlockOrderNumber.Text = $"Заказ №{_currentOrder.OrderID}";
            }
            //TextBlockTotalCost.Text = $"Итого {:C}";
            //DateTimeOrderCreateDate.Value = _currentOrder.OrderCreateDate;
            //OrderDeliveryDate.Text = _currentOrder.OrderDeliveryDate.ToLongDateString();
            TextBlockOrderGetCode.Text = _currentOrder.GetCode.ToString();
            DataContext = _currentOrder;
            ComboPickupPoint.ItemsSource = DataDBEntities.GetContext().PickupPoints.ToList();
            ComboService.ItemsSource = DataDBEntities.GetContext().Services.ToList();
            ComboZone.ItemsSource = DataDBEntities.GetContext().Zones.ToList();
            DataGridRate.ItemsSource = DataDBEntities.GetContext().Rates.OrderBy(p => p.Service.Name).
                ThenBy(p => p.Zone.Name).
                ThenBy(p => p.Weight).
                ThenBy(p => p.Price).ToList();

        }

        static Order CreateNewOrder()
        {
            Order order = new Order();
            if (DataDBEntities.GetContext().Orders.Count() == 0)
            {
                order.OrderID = 1;
            }
            else
            {
                order.OrderID = DataDBEntities.GetContext().Orders.Max(p => p.OrderID) + 1; ;
            }
            order.OrderCreateDate = DateTime.Now;
            order.OrderStatusID = 1;
            order.OrderDeliveryDate = DateTime.Now.AddDays(1);
            Random rnd = new Random();
            order.GetCode = rnd.Next(100, 1000);
            return order;
        }

        private void ComboService_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            LoadRate();
        }

        private void ComboZone_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            LoadRate();
        }

        private void UpDownWeight_ValueChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            LoadRate();
        }

        private void LoadRate()
        {
            // получаем текущие данные из бд
            var currentData = DataDBEntities.GetContext().Rates.OrderBy(p => p.Service.Name).
                ThenBy(p => p.Zone.Name).
                ThenBy(p => p.Weight).
                ThenBy(p => p.Price).ToList();
            // выбор только тех товаров, по определенному диапазону скидки
            if (ComboService.SelectedIndex > -1)
            {
                currentData = currentData.Where(p => p.ServiceId == (ComboService.SelectedItem as Service).ServiceId).ToList();
                int days = (ComboService.SelectedItem as Service).DaysCount;
                DateTime ?current = DateTimeOrderCreateDate.Value;
                current = current.Value.AddDays(days);
                _currentOrder.OrderDeliveryDate = Convert.ToDateTime(current);
                DateTimeOrderDeliveryDate.Value = Convert.ToDateTime(current);
                double maxweight = currentData.Max(p => p.Weight);
                UpDownWeight.Maximum = maxweight;
            }
            if (ComboZone.SelectedIndex > -1)
                currentData = currentData.Where(p => p.ZoneId == (ComboZone.SelectedItem as Zone).ZoneID).ToList();


            if ((UpDownWeight.Value > 0) && (ComboService.SelectedIndex > -1) && (ComboZone.SelectedIndex > -1))
            {
                currentData = currentData.Where(p => p.Weight >= UpDownWeight.Value).ToList().GetRange(0, 1);
            }
            else
            if (UpDownWeight.Value > 0)
            {
                currentData = currentData.Where(p => p.Weight >= UpDownWeight.Value).ToList();
            }

            DataGridRate.ItemsSource = currentData;
        }

        // отображение номеров строк в DataGrid
        private void DataGridGoodLoadingRow(object sender, DataGridRowEventArgs e)
        {
            e.Row.Header = (e.Row.GetIndex() + 1).ToString();
        }


    }
}
