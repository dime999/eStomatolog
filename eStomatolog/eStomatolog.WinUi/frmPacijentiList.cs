using eStomatologModel;
using Flurl.Http;
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
    public partial class frmPacijentiList : Form
    {
        public APIService ProductService { get; set; } = new APIService("Pacijent");

        public frmPacijentiList()
        {
            InitializeComponent();
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var list = await ProductService.Get<List<Pacijent>>();
        }
    }
}
