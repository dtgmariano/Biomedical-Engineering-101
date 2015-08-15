using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Blink102
{
    public partial class Form1 : Form
    {
        bool flag_timer1 = false;
        bool flag_timer2 = false;
        bool flag_timer3 = false;
        bool flag_timer4 = false;
        bool flag_button = false;

        public Form1()
        {
            InitializeComponent();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (flag_timer1 == true)
            {
                pbUp.BackColor = System.Drawing.Color.Black;
                flag_timer1 = false;
            }
            else
            {
                pbUp.BackColor = System.Drawing.Color.Red;
                flag_timer1 = true;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (flag_button == true)
            {
                lbUp.Text = "Off";
                lbLeft.Text = "Off";
                lbRight.Text = "Off";
                lbDown.Text = "Off";
                timer1.Enabled = false;
                timer2.Enabled = false;
                timer3.Enabled = false;
                timer4.Enabled = false;
                flag_button = false;
            }
            else
            {
                timer1.Interval = Convert.ToInt32(numericUpDown1.Value);
                lbUp.Text = timer1.Interval.ToString();
                timer2.Interval = timer1.Interval + 100;
                lbLeft.Text = timer2.Interval.ToString();
                timer3.Interval = timer1.Interval + 200;
                lbRight.Text = timer3.Interval.ToString();
                timer4.Interval = timer1.Interval + 300;
                lbDown.Text = timer4.Interval.ToString();
                timer1.Enabled = true;
                timer2.Enabled = true;
                timer3.Enabled = true;
                timer4.Enabled = true;
                flag_button = true;
            }
            
        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            if (flag_timer2 == true)
            {
                pbLeft.BackColor = System.Drawing.Color.Black;
                flag_timer2 = false;
            }
            else
            {
                pbLeft.BackColor = System.Drawing.Color.Red;
                flag_timer2 = true;
            }
        }

        private void timer3_Tick(object sender, EventArgs e)
        {
            if (flag_timer3 == true)
            {
                pbRight.BackColor = System.Drawing.Color.Black;
                flag_timer3 = false;
            }
            else
            {
                pbRight.BackColor = System.Drawing.Color.Red;
                flag_timer3 = true;
            }
        }

        private void timer4_Tick(object sender, EventArgs e)
        {
            if (flag_timer4 == true)
            {
                pbDown.BackColor = System.Drawing.Color.Black;
                flag_timer4 = false;
            }
            else
            {
                pbDown.BackColor = System.Drawing.Color.Red;
                flag_timer4 = true;
            }
        }
    }
}
