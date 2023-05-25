namespace eStomatolog.WinUi
{
    partial class frmChoose
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnDoktor = new System.Windows.Forms.Button();
            this.btnPacijent = new System.Windows.Forms.Button();
            this.lblPitanje = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btnDoktor
            // 
            this.btnDoktor.Location = new System.Drawing.Point(45, 142);
            this.btnDoktor.Name = "btnDoktor";
            this.btnDoktor.Size = new System.Drawing.Size(100, 57);
            this.btnDoktor.TabIndex = 0;
            this.btnDoktor.Text = "Registruj doktora";
            this.btnDoktor.UseVisualStyleBackColor = true;
            this.btnDoktor.Click += new System.EventHandler(this.btnDoktor_Click);
            // 
            // btnPacijent
            // 
            this.btnPacijent.Location = new System.Drawing.Point(161, 142);
            this.btnPacijent.Name = "btnPacijent";
            this.btnPacijent.Size = new System.Drawing.Size(100, 57);
            this.btnPacijent.TabIndex = 1;
            this.btnPacijent.Text = "Registruj pacijenta";
            this.btnPacijent.UseVisualStyleBackColor = true;
            this.btnPacijent.Click += new System.EventHandler(this.btnPacijent_Click);
            // 
            // lblPitanje
            // 
            this.lblPitanje.AutoSize = true;
            this.lblPitanje.Location = new System.Drawing.Point(87, 70);
            this.lblPitanje.Name = "lblPitanje";
            this.lblPitanje.Size = new System.Drawing.Size(131, 15);
            this.lblPitanje.TabIndex = 2;
            this.lblPitanje.Text = "Koga zelite registrovati?";
            // 
            // frmChoose
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(318, 246);
            this.Controls.Add(this.lblPitanje);
            this.Controls.Add(this.btnPacijent);
            this.Controls.Add(this.btnDoktor);
            this.Name = "frmChoose";
            this.Text = "frmChoose";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Button btnDoktor;
        private Button btnPacijent;
        private Label lblPitanje;
    }
}