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
using System.Windows.Shapes;
using WpfAppPonyExpress.Models;

namespace WpfAppPonyExpress.Windows
{
    /// <summary>
    /// Логика взаимодействия для RateWindow.xaml
    /// </summary>
    public partial class RateWindow : Window
    {
        public Rate currentItem { get; private set; }


        public RateWindow(Rate p)
        {
            InitializeComponent();
            currentItem = p;

            MessageBox.Show(currentItem.ServiceId.ToString());
            MessageBox.Show(currentItem.Service.Name);
            List<Service> services = DataDBEntities.GetContext().Services.OrderBy(x=>x.Name).ToList();

            ComboBoxService.ItemsSource = services;

            List<Zone> zones = DataDBEntities.GetContext().Zones.OrderBy(x => x.Name).ToList();
            ComboBoxZone.ItemsSource = zones;

           

            DataContext = currentItem;
        }


        private StringBuilder CheckFields()
        {
            StringBuilder s = new StringBuilder();
            if (UpDownPrice.Value is null)
                s.AppendLine("Цена не указана");
            if (UpDownWeight.Value is null)
                s.AppendLine("Вес не указан");
            if (ComboBoxService.SelectedIndex == -1)
                s.AppendLine("Не выбрана услуга");
            if (ComboBoxZone.SelectedIndex == -1)
                s.AppendLine("Не выбрана зона");
            return s;
        }
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder _error = CheckFields();
            // если ошибки есть, то выводим ошибки в MessageBox
            // и прерываем выполнение 
            if (_error.Length > 0)
            {
                MessageBox.Show(_error.ToString());
                return;
            }
            currentItem.Price = Convert.ToInt32(UpDownPrice.Value);

            currentItem.Weight = Convert.ToInt32(UpDownWeight.Value);
            
            currentItem.ServiceId = Convert.ToInt32(ComboBoxService.SelectedValue);
            currentItem.ZoneId = Convert.ToInt32(ComboBoxZone.SelectedValue);
            //   currentItem.CategoryId = Convert.ToInt32(ComboCategory.SelectedValue);
            this.DialogResult = true;
        }


    }
}
