using eStomatologModel;
using Microsoft.VisualBasic.ApplicationServices;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace eStomatolog.WinUi
{
    public partial class frmLogin : Form
    {

        private readonly APIService _api = new APIService("Login");
        

        public frmLogin()
        {
            InitializeComponent();
        }


        private async void btnLogin_Click(object sender, EventArgs e)
        {
            APIService.Username = txtUsername.Text;
            APIService.Password= txtPassword.Text;
            try
            {
                var result = await _api.Login<Korisnik>(txtUsername.Text, txtPassword.Text);
                if (result!=null)
                {
                    if (result.RoleNames == "Administrator")
                    {
                        this.Hide();
                        Manager.ManagerHome frm = new Manager.ManagerHome(result);
                        frm.Closed += Close;
                        frm.Show();
                    }
                    else
                    {
                        MessageBox.Show("Nemate dozvolu da pristupite admin panelu!");
                    }
                }
                else if(result==null)
                {
                    MessageBox.Show("Unijeli ste pogresan username i password!");
                }
               
            }
            catch (Exception)
            {
                MessageBox.Show("Pogresan username ili password!");
            }
        }

        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
