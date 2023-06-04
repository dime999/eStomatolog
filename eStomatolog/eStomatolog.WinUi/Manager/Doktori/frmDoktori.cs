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
            //var reqHD = new HairDresserSearchRequest() { HairSalonId = _hairSalon.HairSalonId };



            List<DoktorOrdinacijaDoktorInfo> rezultat = await _doktorOrdinacija.GetByDoktorId<List<DoktorOrdinacijaDoktorInfo>>(_ordinacija.OrdinacijaId);

            dgvDoktori.DataSource = rezultat;

            DataGridViewTextBoxColumn nazivKolona = new DataGridViewTextBoxColumn();
            nazivKolona.DataPropertyName = "DoktorIme";
            nazivKolona.HeaderText = "Ime";
            nazivKolona.Width = 200;
            dgvDoktori.Columns.Add(nazivKolona);


            DataGridViewTextBoxColumn adresaKolona = new DataGridViewTextBoxColumn();
            adresaKolona.DataPropertyName = "DoktorPrezime";
            adresaKolona.HeaderText = "Prezime";
            adresaKolona.Width = 200;
            dgvDoktori.Columns.Add(adresaKolona);

            //dgvEmployees.AutoGenerateColumns = false;
            //populate_dgvEmployees(_hairSalonHairDressers, _hairSalonManagers);
        }
    }
}
