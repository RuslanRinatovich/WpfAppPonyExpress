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

namespace WpfAppPonyExpress.Pages
{
    /// <summary>
    /// Логика взаимодействия для ZoneWindow.xaml
    /// </summary>
    public partial class ZoneWindow : Window
    {
        public Zone currentItem { get; private set; }



        public ZoneWindow(Zone p)
        {
            InitializeComponent();

            currentItem = p;

            TbName.Text = p.Name;
            DataContext = currentItem;

        }


        private StringBuilder CheckFields()
        {
            StringBuilder s = new StringBuilder();
            if (TbName.Text == "")
                s.AppendLine("Введите название");
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

