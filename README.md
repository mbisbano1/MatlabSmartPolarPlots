## **Smart Directivity Polar Plots in MatLab**

### Table of Contents:

1. [Plot Setup Tab](https://github.com/mbisbano1/MatlabSmartPolarPlots/blob/main/README.md#plot-setup-tab-configuring-the-plot-to-your-liking)
2. [Data Import Tab](https://github.com/mbisbano1/MatlabSmartPolarPlots/blob/main/README.md#data-import-tab-plotting-directivity-from-recorded-or-old-data)
3. [Function Input and Plotting](https://github.com/mbisbano1/MatlabSmartPolarPlots/blob/main/README.md#function-input-and-plotting)
4. [Saving Plot Images](https://github.com/mbisbano1/MatlabSmartPolarPlots/blob/main/README.md#saving-plot-images)









### **Plot Setup Tab: Configuring the plot to your liking**
- #### **Plot Style**
	- Choose between a normal linear scale or a dB scale.
- #### **Scale Factor**
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

- #### **Half Power Helper Line**
	- This Toggle button enables/disables the drawing of the -3dB marker line. This is useful for many engineering applications, and is plotted with grey dotted lines. For dB plots it is always drawn at -3dB, but for linear plots it is either drawn at 0.707 or 0.5, depending on the selected Scale Factor.

### **Data Import Tab: Plotting directivity from recorded or old data**
- #### **Excel and CSV File Imports**
	- Excel (.xlsx) and .CSV files are both common ways to log, store, and transfer engineering data. To import data from these file types into this application, the files must be formatted in a certain way. The first column of the file **MUST** be theta values (in degrees), and the second column **MUST** be the corresponding data to be plotted **IN LINEAR SCALE**.
	-The application will not do any processing of the data inported from external sources, so if the data goes below 0 or above 1, you will need to correct for that externally.

- #### **Matlab Data File (.MAT) Imports**
	- Matlab Data Files (.MAT) are slightly different for importing into this application. The file **MUST** contain atleast two variables, which must be named **"theta"** and **"linearDirectivity"** accordingly. 
		- The **"theta"** variable must be a row array of degrees, which commonly could be generated using some variation of the code line below:
```
theta = 0:0.5:360;
```

- The **"linearDirectivity"** variable must be a row array of the same length as the theta variable, which could be generated with some variation of the code line below:
```
linearDirectivity = abs(cos(deg2rad(theta)));
```
- Once the **"theta"** and **"linearDirectivity"** variables have been generated in your MatLab workspace, you can save them into a .MAT file type using the command shown below in your MatLab command line:
```
save filename.mat theta linearDirectivity
```
- #### **Viewing the Imported Data**
	- Imported Data will be displayed within the table in the Import Data tab. You can scroll through this to ensure your data was imported correctly if you have any reason to doubt it.

- #### **Plotting the Imported Data**
	- Imported Data will only be plotted if the toggle switch in the Import Data tab is set to On. This prevents the default data in the table from displaying when a user has no need to import data.

### **Function Input and Plotting:**
- #### **User Defined Functions**
	- The application can plot up to 7 curves at the same time, and 6 of these are user defined. These 6 functions can be enabled/disabled by selecting their corresponding **"Function #"** button to the left of the input box. By default, only **"Function 1"** is enabled for plotting. 
		- To modify these functions, the user must type in an equation in terms of **"theta"**, like the example functions provided do. This equation can use any standard matlab function, and operates under the assumption that **"theta"** is in radians to avoid the need for cosd() or any other degree based matlab functions. 
		- To make inputting these functions simpler, you do **not** need to worry about absolute value, after evaluating the equation specified, the application will calculate the absolute value itself. 

- #### **Generating Plots**
	- To generate the plot template based on settings you have selected, simply click the **"Generate Plot Template"** button. You should see the plot template appear and the status lamp next to the button light up. When settings affecting the plot template are changed, the lamp next to the button will go off, indicating that you need to click the button again to update for the changed settings.
	- To generate the plots you have selected, simply click the **"Plot Function"** button. You should see the plots appear and the status lamp next to the button light up. If the plot template needs to be updated or different functions are specified/selected, the lamp next to the button will turn off, indicating that you need to click the button again to update the plots. 

### **Saving Plot Images:**
- #### **MatLab\'s Figure Tools**
	- To save an image of the generated plots, move your mouse cursor over the plot and a set of icons should appear to the top right of it. If you hover over the leftmost one, three options should appear in a dropdown menu.
		- **Save As:** Clicking this option will allow you to save the image as a file, such as a .png or .jpg. 
		- **Copy as Image:** Clicking this option will copy the image to your clipboard, where you should be able to paste it into a Word document or other file using "**CTRL** **+** **V**"
		- **Copy as Vector Graphic:** Clicking this option will also copy the image to your clipboard, providing the same functionality as the "Copy as Image" option, except it will be a Vector Graphic, which performs better for scaling and resizing, and should retain the information of the image better if you plan on resizing a lot.
