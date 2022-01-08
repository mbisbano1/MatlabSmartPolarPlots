# **Smart Directivity Polar Plots in MatLab**

### **Plot Setup Tab: Configuring the plot to your liking** 
- #### **Plot Style**
	- Choose between a normal linear scale or a dB scale.
- #### **dB Scale Factor**
	- In the conversion from linear to dB, there are two common scale factors used depending on convention and the units being measured/reported. In the world of EE, we commonly use 10 for representing Power measurements and 20 for things that can be squared to represent power, like Voltage or Pressure.
		- 10 for Power
		- 20 for Pressure, Voltage, etc.
- #### **dB Scale Maximum & dB Scale Minimum**
	- Conventionally, a dB polar plot for displaying directivity will have a maximum of 0 and a minimum of 40, but these values may be tweaked to suit more flexible needs.

- #### **Y Minimum**
	- This value adjusts how much room is left below the origin of the polar plot. For plots where the entire functions fall between -90 and 90 degrees, this can be set to 0, but when you want the full 360 degrees displayed this should be set to 1.

- #### **Theta Label Step Value**
	- This parameter adjusts at which angle increments the angle label lines are drawn in the background of the plot. Default is 30 degrees.

- #### **Max Theta**
	- This parameter adjusts the maximum +- angle drawn on for angle label lines. If you only want the top half of the polar plot, you may set this to 90, otherwise keeping this at 180 will be sufficient for most cases.

- #### **Radial Label Values: Decreasing Order**
	- This field is where the radius labels are entered. To work correctly, they must be entered in decreasing order. 
		- For linear plots they should start from a maximum like 1, and decrease. They should not contain 0.
		- For dB plots, they should start at a maximum less than or equal to the defined **dB Scale Maximum** and decrease.

- #### **Radial Label Value One Sided Bandwidths**
	- This field is where shape of the plot template is defined, for each **Radial Label Value** listed above, specify what the maximum (one sided) angle you want that radial arch to cross is. You must have atleast the same amount of values here as in the **Radial Label Value** field.
		- **For 360 Degree Plots** If you want 360 degree plots, you must set every one of these values to 180. This will allow all of the radius marker lines to swing from -180 to 180 degrees.
		- **For 180 Degree Plots** If you only want to see the top half of the plot, you must set every one of these values to 90. This will allow all of the radius marker lines to swing from -90 to 90 degrees.

- #### **Radial Label Location**
	- This Selection box determines where in the figure the radial axis labels are located.

- #### **-3dB Helper Line**
	- This Toggle button enables/disables the drawing of the -3dB marker line. This is useful for many engineering applications, and is plotted with grey dotted lines.
