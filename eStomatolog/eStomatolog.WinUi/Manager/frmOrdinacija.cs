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
    public partial class frmOrdinacija : Form
    {
        private Ordinacije _ordinacija { get; set; }
        private Doktor _user;
        private APIService _cityService = new APIService("Grad");
        private APIService _ordinacijaService = new APIService("Ordinacija");

        public frmOrdinacija(Ordinacije ordinacija,Doktor user)
        {
            _ordinacija= ordinacija;
            _user= user;
            InitializeComponent();
        }
        private async void frmHairSalon_Load(object sender, EventArgs e)
        {
            await LoadData();
        }

        private async Task LoadData()
        {
            LoadBasicInfo();
            await LoadCities();
        }

        private async Task LoadCities()
        {
           

        }

        private void LoadBasicInfo()
        {
         
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            
        }

        private void btnDoktori_Click(object sender, EventArgs e)
        {
            
        }

        private void btnServices_Click(object sender, EventArgs e)
        {
            
        }

        private void btnOcjene_Click(object sender, EventArgs e)
        {
            
        }

        private void btnCategories_Click(object sender, EventArgs e)
        {
        
        }

        private void btnRezervacije_Click(object sender, EventArgs e)
        {
           
        }

        private void btnLoyalty_Click(object sender, EventArgs e)
        {
          
        }

        private void btnReports_Click(object sender, EventArgs e)
        {
           
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            
        }

        private void btnSlike_Click(object sender, EventArgs e)
        {
            

        }

        private void FormInit(Form form)
        {
            this.Hide();
            form.Closed += (s, args) => this.Show();
            form.ShowDialog();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}
