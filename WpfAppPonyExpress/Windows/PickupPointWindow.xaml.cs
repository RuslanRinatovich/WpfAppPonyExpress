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
using WpfAppPonyExpress.Models;


namespace WpfAppPonyExpress.Windows
{
    /// <summary>
    /// Логика взаимодействия для PickupPointWindow.xaml
    /// </summary>
    public partial class PickupPointWindow : Window
    {
        public PickupPoint currentItem { get; private set; }


        public PickupPointWindow(PickupPoint p)
        {
            InitializeComponent();

            currentItem = p;

            TbName.Text = p.Address;
            DataContext = currentItem;

        }


        private StringBuilder CheckFields()
        {
            StringBuilder s = new StringBuilder();
            if (TbName.Text == "")
                s.AppendLine("Введите адрес");
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

            this.DialogResult = true;
        }
    }
}

