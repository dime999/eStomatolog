﻿namespace eStomatolog.WinUi.Manager.Doktori
{
    partial class frmDoktori
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
        private void InitializeComponent()
        {
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dgvDoktori = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.txtIme = new System.Windows.Forms.TextBox();
            this.btnDodajDoktora = new System.Windows.Forms.Button();
            this.btnBack = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDoktori)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgvDoktori);
            this.groupBox1.Location = new System.Drawing.Point(12, 67);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(609, 215);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Lista doktora";
            // 
            // dgvDoktori
            // 
            this.dgvDoktori.AllowUserToAddRows = false;
            this.dgvDoktori.AllowUserToDeleteRows = false;
            this.dgvDoktori.BackgroundColor = System.Drawing.SystemColors.ActiveCaption;
            this.dgvDoktori.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvDoktori.Location = new System.Drawing.Point(6, 22);
            this.dgvDoktori.Name = "dgvDoktori";
            this.dgvDoktori.ReadOnly = true;
            this.dgvDoktori.RowTemplate.Height = 25;
            this.dgvDoktori.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvDoktori.Size = new System.Drawing.Size(597, 184);
            this.dgvDoktori.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(15, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(27, 15);
            this.label1.TabIndex = 2;
            this.label1.Text = "Ime";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.txtIme);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Location = new System.Drawing.Point(12, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(609, 49);
            this.groupBox2.TabIndex = 3;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Filteri";
            // 
            // txtIme
            // 
            this.txtIme.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.txtIme.Location = new System.Drawing.Point(60, 19);
            this.txtIme.Name = "txtIme";
            this.txtIme.Size = new System.Drawing.Size(167, 23);
            this.txtIme.TabIndex = 3;
            // 
            // btnDodajDoktora
            // 
            this.btnDodajDoktora.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnDodajDoktora.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnDodajDoktora.ForeColor = System.Drawing.SystemColors.Control;
            this.btnDodajDoktora.Location = new System.Drawing.Point(477, 298);
            this.btnDodajDoktora.Name = "btnDodajDoktora";
            this.btnDodajDoktora.Size = new System.Drawing.Size(138, 23);
            this.btnDodajDoktora.TabIndex = 1;
            this.btnDodajDoktora.Text = "Dodaj novog doktora";
            this.btnDodajDoktora.UseVisualStyleBackColor = false;
            this.btnDodajDoktora.Click += new System.EventHandler(this.btnDodajDoktora_Click);
            // 
            // btnBack
            // 
            this.btnBack.Location = new System.Drawing.Point(12, 298);
            this.btnBack.Name = "btnBack";
            this.btnBack.Size = new System.Drawing.Size(125, 23);
            this.btnBack.TabIndex = 4;
            this.btnBack.Text = "Nazad";
            this.btnBack.UseVisualStyleBackColor = true;
            this.btnBack.Click += new System.EventHandler(this.btnBack_Click);
            // 
            // frmDoktori
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(633, 333);
            this.Controls.Add(this.btnBack);
            this.Controls.Add(this.btnDodajDoktora);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmDoktori";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmDoktori";
            this.Load += new System.EventHandler(this.frmDoktori_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvDoktori)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgvDoktori;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox txtIme;
        private System.Windows.Forms.Button btnDodajDoktora;
        private Button btnBack;
    }
}