using eStomatologModel;
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
        private Korisnik _korisnik { get; set; }

        private APIService _gradoviService = new APIService("Grad");

        public ManagerHome(Korisnik korisnik)
        {
            _korisnik= korisnik;
            InitializeComponent();
        }

        private async void ManagerHome_Load(object sender, EventArgs e)
        {
            await LoadInfo();

        }

        private async Task LoadInfo()
        {
            LoadGradovi();
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

        private async void LoadGradovi()
        {

            var gradovi = await _gradoviService.Get<List<Grad>>();
            cbCity.DataSource = gradovi;
            cbCity.DisplayMember = "Naziv";
            cbCity.ValueMember = "GradId";
        }
    }
}
