using eStomatologModel;
using eStomatologModel.Requests;
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
using System.Xml.Linq;

namespace eStomatolog.WinUi.Manager
{
    public partial class ManagerHome : Form
    {
        private Korisnik _korisnik { get; set; }

        private APIService _gradoviService = new APIService("Grad");
        private APIService _doktorservice = new APIService("Doktor");
        private APIService _korisnikService = new APIService("Korisnik");
        private APIService _ordinacijaService = new APIService("Ordinacija");
        private APIService _doktorOrdinacija = new APIService("DoktorOrdinacija");
        private APIService _doktorKorisnik = new APIService("GetByKorisnikId");

        public ManagerHome(Korisnik korisnik)
        {
            _korisnik= korisnik;
            InitializeComponent();
        }

        private async void ManagerHome_Load(object sender, EventArgs e)
        {
            await LoadData();

        }

        private async Task LoadOrdinacije()
        {
            var Doktor = _doktorKorisnik.GetByKorisnikId<Doktor>(_korisnik.KorisnikId);

               
        }

        private async Task LoadInfo()
        {
            APIService _korisnikEndpoint = new APIService("Login");
            _korisnik = await _korisnikEndpoint.Login<eStomatologModel.Korisnik>(APIService.Username, APIService.Password);
            txtIme.Text=_korisnik.Ime;
            txtSurname.Text = _korisnik.Prezime;
            txtUserName.Text = _korisnik.KorisnickoIme;

        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            txtIme.Enabled = true;
            txtUserName.Enabled = true;
            txtSurname.Enabled = true;
        }

        private async void btnSaveChanges_Click(object sender, EventArgs e)
        {
            KorisniciUpdateRequest request = new KorisniciUpdateRequest()
            {
                Ime = txtIme.Text,
                Prezime = txtSurname.Text,
                KorisnickoIme = txtUserName.Text,
                Status = true
                
            };


            var korisnik = await _korisnikService.Put<eStomatologModel.Korisnik>(_korisnik.KorisnikId, request);
            APIService.Username = request.KorisnickoIme;

            if (korisnik != null)
            {
                MessageBox.Show("Successfully updated user details.", "Success");
            }
            else
            {
                MessageBox.Show("Couldn't update user details.", "Failure");
            }

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

        private async Task LoadData()
        {
          
            await LoadOrdinacije();
            LoadGradovi();
            txtIme.Enabled = false;
            txtUserName.Enabled = false;
            txtSurname.Enabled = false;
            LoadInfo();
        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void btnAddOrdinacija_Click(object sender, EventArgs e)
        {
            //var req = new OrdinacijaUpsertRequest()
            //{
            //    Naziv = txtOrdinacijaNaziv.Text,
            //    Adresa = txtOrdinacijaAdresa.Text,

            //    Grad = cbCity.DisplayMember,

            //    Drzava = "Bosna i Hercegovina",

            //    Telefon = txtTelefon.Text,

            //    Slika="test"

            //};

            ////var Doktor = _doktorKorisnik.GetByKorisnikId<Doktor>(_korisnik.KorisnikId);
            ////int DoktorId = Doktor.Id;

            //var newOrdinacija = _ordinacijaService.Post<Ordinacija>(req);


            ////DoktorOrdinacijaInsertRequest request = new DoktorOrdinacijaInsertRequest()
            ////{
            ////    OrdinacijaId = newOrdinacija.Id,
            ////    DoktorId = Doktor.Id,
            ////};

            ////var doktorOrdinacija = _doktorOrdinacija.Post<DoktorOrdinacija>(request);


            //MessageBox.Show("Uspjesno ste dodali novu ordinaciju!");
            //txtOrdinacijaNaziv.Clear();
            //txtOrdinacijaAdresa.Clear();

            //LoadData();
        }
    }
}
