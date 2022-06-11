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