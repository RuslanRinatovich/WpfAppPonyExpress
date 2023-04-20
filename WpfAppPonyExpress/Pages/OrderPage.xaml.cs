using System;
using System.Collections.Generic;
using System.Data.Entity;
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
using WpfAppPonyExpress.Windows;

namespace WpfAppPonyExpress.Pages
{
    /// <summary>
    /// Логика взаимодействия для OrderPage.xaml
    /// </summary>
    public partial class OrderPage : Page
    {
        int _itemcount = 0; // 
        Order _selected = null;

        public OrderPage()
        {
            InitializeComponent();
            LoadAndInitData();
        }
        void LoadAndInitData()
        {

           
            _itemcount = ListBoxOrders.Items.Count;
            // скрываем кнопки корзины
            var statuses = DataDBEntities.GetContext().OrderStatus.OrderBy(p => p.Name).ToList();
            statuses.Insert(0, new OrderStatu
            {
                Name = "Все типы"
            }
            );
            ComboStatus.ItemsSource = statuses;
            ComboStatus.SelectedIndex = 0;
            TextBlockCount.Text = $" Результат запроса: {_itemcount} записей из {_itemcount}";
        }


        private void UpdateData()
        {
            // получаем текущие данные из бд
            var currentData = DataDBEntities.GetContext().Orders.OrderBy(p => p.OrderID).ToList();
            if (Manager.CurrentUser.RoleId == 3)
                //currentData = DataDBEntities.GetContext().Orders.Where(p => p.UserName == Manager.CurrentUser.UserName).OrderBy(p => p.OrderID).ToList();
            // выбор только тех товаров, по определенному диапазону скидки
            if (ComboStatus.SelectedIndex > 0)
                currentData = currentData.Where(p => p.OrderStatusID == (ComboStatus.SelectedItem as OrderStatu).Id).ToList();

            // выбор тех товаров, в названии которых есть поисковая строка
            currentData = currentData.Where(p => p.GetCode.ToString().ToLower().Contains(TBoxSearch.Text.ToLower())).ToList();

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
            ListBoxOrders.ItemsSource = currentData;
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

        private void ListBoxOrders_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //получаем всех выделенный товар
            _selected = null;
            var selected = ListBoxOrders.SelectedItems.Cast<Order>().ToList();
            if (selected.Count == 0) return;
            _selected = selected[0];

        }

        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
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
            if (Manager.CurrentUser.RoleId == 3)
            {
                ListBoxOrders.ItemsSource = DataDBEntities.GetContext().Orders.Where(p => p.UserName == Manager.CurrentUser.UserName).OrderBy(p => p.OrderID).ToList();
                ListBoxOrders.ContextMenu.Visibility = Visibility.Collapsed;
            }

            else
            // загрузка данных в listview сортируем по названию
            {
                ListBoxOrders.ItemsSource = DataDBEntities.GetContext().Orders.OrderBy(p => p.OrderID).ToList();
                ListBoxOrders.ContextMenu.Visibility = Visibility.Visible;
            }
        }
        private void MenuItemCancel_Click(object sender, RoutedEventArgs e)
        {
            ChangeOrderStatus(6);
        }

        void ChangeOrderStatus(byte id)
        {

           
            // контекстное меню по нажатию правой кнопки мыши
            // если товар не выбран, завершаем работу
            if (_selected == null)
                return;
            List<string> statuses = new List<string> { "", "Создан", "Принят в работу", "Передан в доставку", "В пункте выдачи", "Получен", "Отменён" };
            // добавляем товар в корзину
            MessageBoxResult x = MessageBox.Show($"Вы действительно изменить статус заказа на {statuses[id]}?", "Отмена", MessageBoxButton.OKCancel, MessageBoxImage.Question);
            if (x == MessageBoxResult.OK)
            {
                _selected.OrderStatusID = id;
                DataDBEntities.GetContext().SaveChanges();  // Сохраняем изменения в БД
                LoadOrders();
            }
        }

        private void MenuItemAccept_Click(object sender, RoutedEventArgs e)
        {
            ChangeOrderStatus(2);
        }

        private void MenuItemDeliver_Click(object sender, RoutedEventArgs e)
        {
            ChangeOrderStatus(3);
        }

        private void MenuItemInPoint_Click(object sender, RoutedEventArgs e)
        {
            ChangeOrderStatus(4);
        }

        private void MenuItemGet_Click(object sender, RoutedEventArgs e)
        {
            ChangeOrderStatus(5);
        }
    }
}
