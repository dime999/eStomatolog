using Microsoft.VisualBasic.Logging;
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
    public partial class frmInit : Form
    {
        public frmInit()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            this.Hide();
            frmLogin login = new frmLogin();
            login.Closed += Close;
            login.Show();
        }
       

        private void btnRegister_Click(object sender, EventArgs e)
        {
            this.Hide();
            frmRegister register = new frmRegister();
            register.Closed += Close;
            register.Show();
        }

        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
