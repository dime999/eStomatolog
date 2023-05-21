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
    public partial class frmChoose : Form
    {
        public frmChoose()
        {
            InitializeComponent();
        }

        private void btnDoktor_Click(object sender, EventArgs e)
        {
            this.Hide();
            frmRegister login = new frmRegister();
            login.Closed += Close;
            login.Show();
        }

        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
