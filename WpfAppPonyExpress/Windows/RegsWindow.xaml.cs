using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
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

namespace WpfAppPonyExpress.Windows
{
    /// <summary>
    /// Логика взаимодействия для RegsWindow.xaml
    /// </summary>
    public partial class RegsWindow : Window
    {
        public Client currentItem { get; private set; }
        private string _filePath = null;
        // название текущей главной фотографии
        private string _photoName = null;
        // текущая папка приложения
        private static string _currentDirectory = Directory.GetCurrentDirectory() + @"\Images\";
        bool IsUserNameFree = true;
        public RegsWindow()
        {
            InitializeComponent();
            currentItem = new Client();
            DataContext = currentItem;
        }

        // загрузка фото 
        private void BtnLoadClick(object sender, RoutedEventArgs e)
        {
            try
            {
                //Диалог открытия файла
                OpenFileDialog op = new OpenFileDialog();
                op.Title = "Select a picture";
                op.Filter = "JPEG Files (*.jpeg)|*.jpeg|PNG Files (*.png)|*.png|JPG Files (*.jpg)|*.jpg|GIF Files (*.gif)|*.gif";
                // диалог вернет true, если файл был открыт
                if (op.ShowDialog() == true)
                {
                    // проверка размера файла
                    // по условию файл дожен быть не более 2Мб.
                    FileInfo fileInfo = new FileInfo(op.FileName);
                    if (fileInfo.Length > (1024 * 1024 * 2))
                    {
                        // размер файла меньше 2Мб. Поэтому выбрасывается новое исключение
                        throw new Exception("Размер файла должен быть меньше 2Мб");
                    }
                    ImagePhoto.Source = new BitmapImage(new Uri(op.FileName));
                    _photoName = op.SafeFileName;
                    _filePath = op.FileName;
                }
            }

            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                _filePath = null;
            }
        }
        //подбор имени файла
        string ChangePhotoName()
        {
            string x = _currentDirectory + _photoName;
            string photoname = _photoName;
            int i = 0;
            if (File.Exists(x))
            {
                while (File.Exists(x))
                {
                    i++;
                    x = _currentDirectory + i.ToString() + photoname;
                }
                photoname = i.ToString() + photoname;
            }
            return photoname;

        }


        private StringBuilder CheckFields()
        {
            StringBuilder s = new StringBuilder();

            if (string.IsNullOrWhiteSpace(currentItem.UserName))
                s.AppendLine("Задайте имя пользователя");

            if (!IsUserNameFree)
                s.AppendLine("Имя пользователя должно быть уникальным, выберите другое имя");
            if (string.IsNullOrWhiteSpace(currentItem.Name))
                s.AppendLine("Поле имя пустое");
            
            if (string.IsNullOrWhiteSpace(currentItem.Surname))
                s.AppendLine("Поле фамилия пустое");
            if (string.IsNullOrWhiteSpace(currentItem.Phone))
                s.AppendLine("Поле телефон пустое");
            if (string.IsNullOrWhiteSpace(currentItem.Email))
                s.AppendLine("Поле email пустое");


            if (string.IsNullOrWhiteSpace(currentItem.PassportSeries))
                s.AppendLine("Укажите серию паспорта");
            if (string.IsNullOrWhiteSpace(currentItem.PassportNum))
                s.AppendLine("Укажите номер паспорта");
            if (string.IsNullOrWhiteSpace(_photoName))
                s.AppendLine("фото не выбрано пустое");

            if (string.IsNullOrWhiteSpace(PasswordBoxNewPassword1.Password))
                s.AppendLine("Придумайте пароль");
            if ((PasswordBoxNewPassword1.Password != PasswordBoxNewPassword2.Password) )
                {
                    s.AppendLine("Пароли не совпадают");
                }
               
            return s;
        }

        private void TextBoxUserName_TextChanged(object sender, TextChangedEventArgs e)
        {
            List<User> users = DataDBEntities.GetContext().Users.ToList();
            User user = users.FirstOrDefault(p =>  p.UserName.ToLower() == TextBoxUserName.Text.ToLower());
            if (user != null)
            {
                IsUserNameFree = false;
                TextBoxUserName.Foreground = Brushes.Red;
            }
            else
            {
                IsUserNameFree = true;
                TextBoxUserName.Foreground = Brushes.Green;
            }
          }

        private void Accept_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder _error = CheckFields();
            // если ошибки есть, то выводим ошибки в MessageBox
            // и прерываем выполнение 
            if (_error.Length > 0)
            {
                MessageBox.Show(_error.ToString());
                return;
            }

            if (_photoName != null)
            {


                // формируем новое название файла картинки,
                // так как в папке может быть файл с тем же именем
                string photo = ChangePhotoName();
                // путь куда нужно скопировать файл
                string dest = _currentDirectory + photo;
                File.Copy(_filePath, dest);
                currentItem.Photo = photo;


            }
            try
            {
                User user = new User();
                user.Password = PasswordBoxNewPassword1.Password;
                user.UserName = TextBoxUserName.Text;
                user.RoleId = 3;

                DataDBEntities.GetContext().Users.Add(user);
                DataDBEntities.GetContext().SaveChanges();


                DataDBEntities.GetContext().Clients.Add(currentItem);
                DataDBEntities.GetContext().SaveChanges();
                MessageBox.Show("Регистрация прошла успешно");
                this.DialogResult = true;
                
            }
            catch
            {
                MessageBox.Show("Ошибка");
            }

        }
    }
}
