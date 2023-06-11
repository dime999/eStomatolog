using eStomatologModel;
using eStomatologModel.Requests;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace eStomatolog.WinUi.Manager
{
    public partial class OrdinacijaSlike : Form
    {
        private Ordinacije _ordinacija { get; set; }
        private APIService _slikaStreamService = new APIService("SlikaStream");
        private APIService _slikeIdService = new APIService("OrdinacijaSlikeIds");
        private APIService _slikService = new APIService("Slika");

        private int[] _slikeIds;
        private int _selectedIndex;
        public OrdinacijaSlike(Ordinacije ordinacije)
        {
            _ordinacija = ordinacije;
            InitializeComponent();
        }

        private void OrdinacijaSlike_Load(object sender, EventArgs e)
        {
            initSlike();
        }


        private async void initSlike()
        {
            Galerija gallery = await _slikeIdService.GetOrdinacijaSlikeIds<Galerija>(_ordinacija.OrdinacijaId);
            if (gallery.slikeIds != null && gallery.slikeIds.Count() != 0)
            {
                pbHairSalon.SizeMode = PictureBoxSizeMode.StretchImage;
                _slikeIds = new int[gallery.slikeIds.Count()];
                for (int i = 0; i < gallery.slikeIds.Count(); i++)
                {
                    _slikeIds[i] = gallery.slikeIds.ElementAt(i);
                }
                _selectedIndex = _slikeIds.Count() - 1;
                renderPicture(_slikeIds[_selectedIndex]);
            }
            else
            {
                pbHairSalon.Image = null;
                MessageBox.Show("No images to display! You can add some with the 'Add new image' button.");
            }
        }
        private async void renderPicture(int slikaId)
        {
            ImageConverter converter = new ImageConverter();
            var pictureSource = await _slikaStreamService.GetSlikaStream<byte[]>(slikaId);
            pbHairSalon.Image = null;
            pbHairSalon.Image = (Image)converter.ConvertFrom(pictureSource);
        }

       

        private async void btnNew_Click_1(object sender, EventArgs e)
        {
            var result = ofdNewImage.ShowDialog();
            if (result == DialogResult.OK)
            {
                var request = new SlikaInsertRequest
                {
                    OrdinacijaId = _ordinacija.OrdinacijaId
                };
                using (var fileStream = File.Open(ofdNewImage.FileName, FileMode.Open))
                {
                    using (var client = new HttpClient())
                    {
                        var serializedRequest = JsonConvert.SerializeObject(request);
                        var stringContent = new StringContent(serializedRequest, Encoding.UTF8, "application/json");
                        var multipartContent = new MultipartFormDataContent();
                        using (MemoryStream memoryStream = new MemoryStream())
                        {
                            await fileStream.CopyToAsync(memoryStream);
                            var byteContent = new ByteArrayContent(memoryStream.ToArray());
                            multipartContent.Add(
                                byteContent,
                                Path.GetFileNameWithoutExtension(ofdNewImage.FileName) +
                                DateTime.Now.ToString("yymmssfff") +
                                Path.GetExtension(ofdNewImage.FileName),
                                ofdNewImage.FileName);
                            multipartContent.Add(new StringContent(request.OrdinacijaId.ToString()), "OrdinacijaId");
                            client.DefaultRequestHeaders.Add("Authorization", "Basic " + Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(APIService.Username + ":" + APIService.Password)));
                            var response = await client.PostAsync($"https://localhost:7265/InsertOrdinacijaSlika", multipartContent);
                            MessageBox.Show("Successfully added new image!");
                            initSlike();
                        };

                    }
                }

            }
        }

        private void btnNext_Click_1(object sender, EventArgs e)
        {
            if (_slikeIds[_selectedIndex] == _slikeIds.Last())
            {
                _selectedIndex = 0;
            }
            else
            {
                _selectedIndex++;
            }
            renderPicture(_slikeIds[_selectedIndex]);
        }

        private void btnPrevious_Click_1(object sender, EventArgs e)
        {
            if (_selectedIndex == 0)
            {
                _selectedIndex = _slikeIds.Count() - 1;
            }
            else
            {
                _selectedIndex--;
            }

            renderPicture(_slikeIds[_selectedIndex]);
        }

        private async void btnDelete_Click_1(object sender, EventArgs e)
        {
                int slikaId = _slikeIds[_selectedIndex];
                var picture = await _slikService.IzbrisiSliku<Slika>(slikaId);
                MessageBox.Show("Successfully deleted selected picture.");
                initSlike();   
        }
    }
}
