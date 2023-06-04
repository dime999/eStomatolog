using eStomatolog.WinUi.Manager.Doktori;
using eStomatologModel;
using Microsoft.VisualBasic.ApplicationServices;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace eStomatolog.WinUi.Manager.Pacijent
{
    public partial class frmPacijenti : Form
    {

        private Ordinacije _ordinacija { get; set; }
        private APIService _pacijentOrdinacije = new APIService("DoktorOrdinacija");
        private APIService _pacijenti = new APIService("GetPacijentiByOrdinacijaId");
        private List<PacijentOrdinacija> originalnaLista;
        public frmPacijenti(Ordinacije ordinacija)
        {
            _ordinacija = ordinacija;
            InitializeComponent();
        }

        private void frmPacijenti_Load(object sender, EventArgs e)
        {
            dgvPacijenti.AutoGenerateColumns = false;
            LoadData();
        }

        private async Task LoadData()
        {
            await LoadPacijenti();
        }

        private async Task LoadPacijenti()
        {
            originalnaLista = await _pacijenti.GetByDoktorId<List<PacijentOrdinacija>>(_ordinacija.OrdinacijaId);

            BindingSource bindingSource = new BindingSource();
            bindingSource.DataSource = originalnaLista;

            dgvPacijenti.DataSource = bindingSource;

            DataGridViewTextBoxColumn nazivKolona = new DataGridViewTextBoxColumn();
            nazivKolona.DataPropertyName = "PacijentIme";
            nazivKolona.HeaderText = "Ime";
            nazivKolona.Width = 277;
            dgvPacijenti.Columns.Add(nazivKolona);

            DataGridViewTextBoxColumn adresaKolona = new DataGridViewTextBoxColumn();
            adresaKolona.DataPropertyName = "PacijentPrezime";
            adresaKolona.HeaderText = "Prezime";
            adresaKolona.Width = 277;
            dgvPacijenti.Columns.Add(adresaKolona);

            // Dodajte event handler za promjenu teksta u filter input kontroli
            txtIme.TextChanged += TxtFilter_TextChanged;
        }

        private void TxtFilter_TextChanged(object sender, EventArgs e)
        {
            string filterValue = txtIme.Text.Trim();

            BindingSource bindingSource = (BindingSource)dgvPacijenti.DataSource;

            if (string.IsNullOrEmpty(filterValue))
            {
                bindingSource.DataSource = originalnaLista;
            }
            else
            {
                List<PacijentOrdinacija> filtriranaLista = originalnaLista
                    .Where(d => d.PacijentIme.Contains(filterValue, StringComparison.OrdinalIgnoreCase)
                                || d.PacijentPrezime.Contains(filterValue, StringComparison.OrdinalIgnoreCase))
                    .ToList();

                bindingSource.DataSource = filtriranaLista;
            }

            dgvPacijenti.Refresh();
        }

    }
}
