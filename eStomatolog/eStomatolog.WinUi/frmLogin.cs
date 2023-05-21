using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace eStomatolog.WinUi
{
    public partial class frmLogin : Form
    {

        private readonly APIService _api = new APIService("Korisnik");

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
                var result = await _api.Get<dynamic>();

                this.Hide();
                Manager.ManagerHome frm = new Manager.ManagerHome();
                frm.Closed += Close;
                frm.Show();
                           
            } catch(Exception ex)
            {
                MessageBox.Show("Pogresan username ili password");
            }
        }

        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
