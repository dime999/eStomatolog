using eStomatologModel;
using eStomatologModel.SearchObjects;
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

namespace eStomatolog.WinUi.Manager.Rezervacije
{
    public partial class frmRezervacija : Form
    {
        private Ordinacije _ordinacija { get; set; }
        private Doktor _user { get; set; }
        private APIService _doktorService = new APIService("Doktor");
        private APIService _rezervacijaService = new APIService("Rezervacija");

        public frmRezervacija(Ordinacije _ordinacija,Doktor _user)
        {
            InitializeComponent();
            this._ordinacija= _ordinacija;
            this._user = _user;
            dgvRezervacije.AutoGenerateColumns = false;
        }

        private async void frmRezervacija_Load(object sender, EventArgs e)
        {
            await LoadData();
        }

        private async Task LoadData()
        {
            await LoadDoktori();
            await LoadRezervacije();
        }

        private async Task LoadRezervacije()
        {
            var rezervacijaSearch = new RezervacijaSearchRequest
            {
                OrdinacijaId = _ordinacija.OrdinacijaId
            };

            var result = await _rezervacijaService.Get<List<eStomatologModel.Rezervacija>>(rezervacijaSearch);
            dgvRezervacije.DataSource = result;

            DataGridViewTextBoxColumn doktor = new DataGridViewTextBoxColumn();
            doktor.DataPropertyName = "DoktorIme";
            doktor.HeaderText = "Doktor ime";
            doktor.Width = 220;
            dgvRezervacije.Columns.Add(doktor);

            DataGridViewTextBoxColumn pacijent = new DataGridViewTextBoxColumn();
            pacijent.DataPropertyName = "PacijentPrezime";
            pacijent.HeaderText = "Pacijent prezime";
            pacijent.Width = 220;
            dgvRezervacije.Columns.Add(pacijent);

            DataGridViewTextBoxColumn ordinacija = new DataGridViewTextBoxColumn();
            ordinacija.DataPropertyName = "OrdinacijaIme";
            ordinacija.HeaderText = "Ordinacija ime";
            ordinacija.Width = 220;
            dgvRezervacije.Columns.Add(ordinacija);
        }



        private async Task LoadDoktori()
        {
            var request = new DoktoriSearchRequest();
            request.Ime = _user.Ime;

            var result = await _doktorService.Get<List<Doktor>>(request);

            cbDoktori.DataSource = result;
            cbDoktori.DisplayMember = "Ime";
            cbDoktori.ValueMember = "Id";

        }
    }
}
