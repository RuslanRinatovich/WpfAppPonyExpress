﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfAppPonyExpress.Models
{
    public partial class Client
    {
        public string GetPhoto
        {
            get
            {
                if (Photo is null)
                    return null;
                return System.IO.Directory.GetCurrentDirectory() + @"\Images\" + Photo.Trim();
            }
        }
        public string GetFio
        {
            get
            {
                return $"{Surname} {Name} ";
            }
        }
    }
}
