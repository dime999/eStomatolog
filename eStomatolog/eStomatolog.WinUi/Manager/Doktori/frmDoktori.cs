using eStomatologModel;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace eStomatolog.WinUi.Manager.Doktori
{
    public partial class frmDoktori : Form
    {
        private Ordinacije _ordinacija { get; set; }
        private Doktor _user { get; set; }
        private List<Doktor> _doktori;
        private APIService _doktoriOrdinacije = new APIService ("DoktorOrdinacija");
        private APIService _doktorOrdinacija = new APIService("GetByOrdinacijaId");
        private List<DoktorOrdinacijaDoktorInfo> originalnaLista;
        public frmDoktori(Ordinacije ordinacija, Doktor user)
        {
            _ordinacija= ordinacija;
            _user=user;
            InitializeComponent();
        }

        private void frmDoktori_Load(object sender, EventArgs e)
        {
            dgvDoktori.AutoGenerateColumns = false;
            LoadData();
        }

        private async Task LoadData()
        {
            await LoadDoktori();
        }

        private async Task LoadDoktori()
        {
            originalnaLista = await _doktorOrdinacija.GetByDoktorId<List<DoktorOrdinacijaDoktorInfo>>(_ordinacija.OrdinacijaId);

            BindingSource bindingSource = new BindingSource();
            bindingSource.DataSource = originalnaLista;

            dgvDoktori.DataSource = bindingSource;

            DataGridViewTextBoxColumn nazivKolona = new DataGridViewTextBoxColumn();
            nazivKolona.DataPropertyName = "DoktorIme";
            nazivKolona.HeaderText = "Ime";
            nazivKolona.Width = 277;
            dgvDoktori.Columns.Add(nazivKolona);

            DataGridViewTextBoxColumn adresaKolona = new DataGridViewTextBoxColumn();
            adresaKolona.DataPropertyName = "DoktorPrezime";
            adresaKolona.HeaderText = "Prezime";
            adresaKolona.Width = 277;
            dgvDoktori.Columns.Add(adresaKolona);

            // Dodajte event handler za promjenu teksta u filter input kontroli
            txtIme.TextChanged += TxtFilter_TextChanged;
        }

        private void TxtFilter_TextChanged(object sender, EventArgs e)
        {
            string filterValue = txtIme.Text.Trim();

            BindingSource bindingSource = (BindingSource)dgvDoktori.DataSource;

            if (string.IsNullOrEmpty(filterValue))
            {
                bindingSource.DataSource = originalnaLista;
            }
            else
            {
                List<DoktorOrdinacijaDoktorInfo> filtriranaLista = originalnaLista
                    .Where(d => d.DoktorIme.Contains(filterValue, StringComparison.OrdinalIgnoreCase)
                                || d.DoktorPrezime.Contains(filterValue, StringComparison.OrdinalIgnoreCase))
                    .ToList();

                bindingSource.DataSource = filtriranaLista;
            }

            dgvDoktori.Refresh();
        }

        private void btnDodajDoktora_Click(object sender, EventArgs e)
        {
    
            this.Hide();
            frmDoktoriAdd frm = new frmDoktoriAdd(_ordinacija, _user);
            frm.Closed += Close;
            frm.Show();
        }
        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
