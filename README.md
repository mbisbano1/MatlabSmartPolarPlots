## **Smart Directivity Polar Plots in MatLab**

### Table of Contents:

1. [Function Banks and General Plotting]
2. [Plot Setup Tab]
3. [Predefined Patterns Tab]
4. [Import Data Tab]
5. [Saving Plot Images]
6. [Directivity Calculations]
7. [More Help]


### **Function Bank: Specify what to Plot**
- #### **Function Toggles**
	- Enable/Disable the plotting of a given function. If the Function # button is Gray, it will be plotted.
- #### **Equation Entry Fields**
	- Manually specify an equation to plot as a function of theta. These boxes will be pre-filled upon starting the program with some examples.
	- **ABSOLUTE VALUE** is taken on the resulting values before plotting.
	- **SYNTAX**: All equations should follow the standard matlab equation syntax, and the **theta** variable is a vector so the . (dot) operator should be used for multiplications or divides.
	- **Predefined Functions**: Functions that are selected in the Predefined Patterns tab will type in the correct equation here for the user.
	- **SINC & JINC**: To use SINC and JINC functions, you must use type them specially, as they are not standard functions in Matlab and as such I had to add my own versions to this app. These functions remove the discontinuity at x == 0. Call these using the app.mysinc(argument) notation.
		- **SINC**: y = app.mysinc(x) = sin(pi * x)/(pi * x)
		- **JINC**: y = app.myjinc(x) = 2*besselj(1,x)/(x) 
- #### **Legend Entries**
	- If the Plot Legend is enabled, the strings shown in these fields will be displayed for the given functions' Legend Entry.
- #### **Directivities**
	- If the function being plotted is correctly imported/typed in properly **AND** it is computationally reasonable to solve the Directivity for, the functions' directivity will be displayed here after **Plot Function** is clicked. If the calculation of Directivity fails for any reason, the field will be populated with a -1. Read more about the calculation of Directivity values in the Directivity help tab.
- #### **Line Type**
	- To allow greater differentiation between different functions being plotted (especially when only using black and white) each functions' line type can be specified. This dropdown allows the user to select the line type for each function.
- #### **Line Color**
	- Each functions' color can be specified for plotting. This dropdown allows the user to specify the color of each function. By Right clicking the 'Line Color' text a few presets for line colors are available.


### **Plot Setup Tab: Configuring the plot to your liking**
- #### **Plot Style**
	- Choose between a normal linear scale or a dB scale.
- #### **Scale Factor**
	- In the conversion from linear to dB, there are two common scale factors used depending on convention and the units being measured/reported. In the world of EE, we commonly use 10 for representing Power measurements and 20 for things that can be squared to represent power, like Voltage or Pressure.
		- 10 for Power
		- 20 for Pressure, Voltage, etc.
- #### **Radial Label Location**
	- This Selection box determines where in the figure the radial axis labels are located.
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
- #### **Default Settings Modes**
	- These Toggle buttons offer a few pre-configured settings for many use cases.
- #### **Half Power Helper Line**
	- This Toggle button enables/disables the drawing of the -3dB marker line. This is useful for many engineering applications, and is plotted with grey dotted lines. For dB plots it is always drawn at -3dB, but for linear plots it is either drawn at 0.707 or 0.5, depending on the selected Scale Factor.
- #### **Discard Redundant Mirrors**
	- This Toggle button enables/disables the plotting of functions (that the application determines sufficiently symmetrical over the horizontal axis) below the horizontal axis.
		- For 360° plots this setting depends on your preference.
		- For 180° plots the setting should have no effect.
- #### **Legend Settings**
	- The user can configure if/where the Legend appears near the plot. After updating any of these settings click **Plot Function** again to update the display.
- #### **Custom Settings Files**
	- These Export and Load buttons allow user defined configurations to be saved for later or shared with others. The settings fields that will be saved/loaded are:
		- Plot Style
		- Scale Factor
		- Radial Label Location
		- dB Scale Maximum
		- dB Scale Minimum
		- Y Minimum
		- Theta Label Step Size
		- Max Theta
		- Radial Label Values: Decreasing Order
		- Radial Label Value One Sided BW
		- Half Power Helper Line
		- Discard Redundant Mirrors
		- Legend Settings
		- Function Bank Line Types and Line Colors
	- **Export**: To save your current settings click the **Export Settings** button, and specify a File name. This will save your settings as an Excel file, which can be loaded in and parsed later. Be sure to name the file properly.
	- **Load**: To load previously saved settings click the **Load Settings** button, and select the Excel file you would like to load. This will configure all settings to match those saved in the target file.


### **Predefined Patterns: Reference Common Ideal Directional Factors**
These Predefined Patterns can be loaded into any of the six Function Banks, using their **Function to Add to:** entry and the **Add** button.
When the **Add** button is clicked, the current settings for each directional factor equation will be written into the selected Function Bank's equation field.
- #### **Continuous Line Sources**
	- Continuous Line Sources are parameterized by **kL**. 
		- **kL** is the product of wavenumber **k** and the total length of the source **L**
	- The **kL** parameter can be specified as a number or by relation to pi
	- See section 7.3 of **Fundamentals of Acoustics** by **KFCS**
- #### **Plane Circular Piston Sources**
	- Circular Pistons are parameterized by **ka** 
		- **ka** is the wavenumber **k** multiplied by the piston's radius **a**
	- The **ka** parameter can be specified as a number or by relation to pi
	- See section 7.4 of **Fundamentals of Acoustics** by **KFCS**
- #### **Continuous Line Array Sources**
	- Continuous Line Arrays are parameterized by **N**, **kd**, and **Theta_0**
		- **N** is the number of elements
		- **kd** is the wavenumber **k** multiplied by **d** the distance between each element
		- **Theta_0** is the steered angle of the array (when a phase delay is applied between elements)
	- The **N** parameter can only be specified as an integer number
	- The **kd** parameter can be specified as a number or by relation to pi	
	- See section 7.8 of **Fundamentals of Acoustics** by **KFCS**
- #### **Cardioid Sources**
	- Cardioid Sources are only parameterized by their steered angle **Theta_0**.
- #### **Cosine to Power**
	- Cosine to Power sources are only parameterized by their power **m**.


### **Import Data: Take Lab Results to Publication**
The Import Data tab is likely the most complicated of all sections in this program. With a bit of patience it should become straight forward. I am open to critiques on the user interface here if you as a user have any suggestions!

**Principle of Operation**:
	- **Table Workspace**: This is where imported data can be modified and manipulated before plotting. Think of this table as a temporary location just for the viewing of data. During a session, there are six save slots available for imported functions to plot. Using the Table Workspace the user can view what is stored in these slots and modify as they please. All the plotting of imported data is done with the data currently saved in save slots. That means, just because data is displayed in the table, does not mean it is the data that has been plotted.
- **Excel/CSV/MAT Importing**: Click the corresponding import button for your data format. This will load the data into the Table Workspace. Right clicking each of these buttons will allow the user to view a template version of an importable file. These templates must be followed **EXACTLY**. Having extra calculations off to the side will throw off the importing process. 
	- **For Excel**: If you are following the templates as shown, and imports are still not working, you may have stray (invisible) data in some other cells. Select the first two columns of data and copy; then create a new spreadsheet and right click in the top left cell, selecting Paste -> Values. This new spreadsheet should work.
- **Operations on Table Data**: Data imported into the table may not be formatted properly for plotting, so there are a limited number of automated functions that can be performed on that data included in this program. The Table data **must then be saved into a save slot for viewing**.
	- **Take Absolute Value**: Directional Factor plots are only meant to display magnitude, so if imported data has negative values, you can use this to take the absolute value of every DF data point in the table.
		- **DF(i) = abs(DF(i))** for all i
	- **Scale By Max Value**: Directional Factor plots are meant to display radius values in the range of 0 to 1. If the imported data in the table needs to be scaled down to this range, this button will do so.
		 - **DF(i) = DF(i)/MAX(DF)** for all i
	- **Insert/Remove Elements**: For directivity calculations, the start/stop angles are important. This is discussed in more detail in the **Directivity Help** section. If imported data has a few extra data points at the beginning or end, these can be removed, or data points can be added if there are a few missing at the edges.
**Imported Save Slots**:
	- **Save**: Take data in Table Workspace and store in selected Import Save Slot.
	- **Load**: Load data from selected Import Save Slot into Table Workspace.
The save slots provide a way of plotting more than just one imported dataset at a time, as well as making the code convenient to write. As mentioned above, Data in the Table Workspace is not what gets plotted, when adding the imported data to a Function Bank. When the User clicks the **Add** button to add data to a function bank, the data saved in the currently selected **Import Save Slot** is what gets transferred to the Function Bank. That means when data is imported from Excel/CSV/MAT files it is not yet saved to a Import Save Slot, and thus will not be the data plotted if you click the **Add** button. You need to Select an Import Slot you don\'t mind overwriting and select hit **Save**, and only then will Add store the most recent data in the selected Function Bank.

### **Directivity Calculations: Quantify Directive Gain**
Directivity Calculations are performed following a modified version of Equation 7.6.8 from KFCS. Assuming Uniformity in Phi, we can simplify this and only integrate through theta, as shown in the equation below.

Computation is done using MATLAB\'s trapz() function, which approximates integration through the Trapezoidal Riemann Sum. Accuracy is proportional to the theta measurement step sizes, with larger step sizes resulting in more gross approximations.

To avoid complications at zero crossings of the sin(theta) function, inputs are broken up in quadrant segments, integrated separately, and then summed. Due to this, the input format for data is quite particular. Some rules for input formats are listed below:

1. **Uniform Theta Step Size**: The difference in theta from one data point to the next must be uniform over the entire set of data. Meaning measurements taken from 0 to 360 degrees with a step size of 1 degree will be taken at 0, 1, 2, ..., 358, 359 degrees.
2. **Theta Bounds**: The edges of sample points must be in an order expected by Directivity Calculation code. You cannot expect data taken starting at 30 degrees and going to 389 degrees to work properly, and to compensate for this you may need to manually reformat some measurement data before inputting/importing it into this program. Acceptable formats are listed below, with dTheta being the theta step size between each sample:
	- -180 to (180-dTheta) degrees
	- -90 to (90-dTheta) degrees
	- 0 to (360-dTheta) degrees

3. **Sample Overlap**: Notice in the Theta Bounds rule that the range does not allow overlapping samples (0 and 360 degrees, etc), so if your imported data contains these overlap points, you must remove them manually, either using the Remove First/Last Element buttons or externally before importing. An example would be data collected between 0 and 360 with a dTheta of 0.1 degree. The correct range for importing would have a **minimum** theta of 0 degrees and a **maximum** theta of 359.9 degrees.


### **Saving Plot Images:**
- To save an image of the generated plots, the "Open External Figure Window for Saving/Copying Image" button handles this.
	- If you want to save the image as a standalone file, you can do this from within the external figure that opens, using the save button, specifying file name, and selecting the desired file type.
	- If you want to copy the image into another file, like a Word document, use the toolbar above the image and select the "Copy as Image" option.
- An alternative to this is using the standard Windows shortcut (WIN + SHIFT + S) which will allow you to select a region of the screen to save as a picture.


### **More Help on GitHub Pages**
If you are having issues beyond what is explained in this Readme, feel free to browse for help on the Project's GitHub pages. You will be able to see the source code, latest releases, and can even report an issue through the Issues page. This will generate an email with your issues to every GitHub account that maintains the repository, and offers a clean method for those fixing it to track progress and update you once it has been resolved. Any critiques on the user interface or requests for more features are welcome, and can also be made through the *Issues* page as well.

