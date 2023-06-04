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
        public frmDoktori(Ordinacije ordinacija, Doktor user)
        {
            _ordinacija= ordinacija;
            _user=user;
            InitializeComponent();
        }

        private void frmDoktori_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        private async Task LoadData()
        {
            await LoadDoktori();
        }

        private async Task LoadDoktori()
        {
            //var reqHD = new HairDresserSearchRequest() { HairSalonId = _hairSalon.HairSalonId };
           

           
            //_doktori = await _managers.Get<List<HairSalonManager>>(reqM);

            //dgvEmployees.AutoGenerateColumns = false;
            //populate_dgvEmployees(_hairSalonHairDressers, _hairSalonManagers);
        }
    }
}
