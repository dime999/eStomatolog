using Microsoft.VisualBasic.ApplicationServices;
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

namespace eStomatolog.WinUi.Manager
{
    public partial class ManagerHome : Form
    {
        public ManagerHome()
        {
            InitializeComponent();
        }

        private async void ManagerHome_Load(object sender, EventArgs e)
        {
            

        }

        private async void LoadInfo()
        {
           
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            txtIme.Enabled = true;
            txtUserName.Enabled = true;
            txtSurname.Enabled = true;
        }

        private async void btnSaveChanges_Click(object sender, EventArgs e)
        {
            

        }

        private async void btnAddHairSalon_Click(object sender, EventArgs e)
        {
           
        }

        private async void dgvManagerHome_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
           
        }
    }
}
