<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.pi4j.io.gpio.GpioController"%>
<%@ page import="com.pi4j.io.gpio.GpioFactory"%>
<%@ page import="com.pi4j.io.gpio.GpioPinDigitalOutput"%>
<%@ page import="com.pi4j.io.gpio.PinState"%>
<%@ page import="com.pi4j.io.gpio.RaspiPin"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
//create gpio controller
		GpioController gpio = GpioFactory.getInstance();

		// Set up the pins and set low to start
		System.out.print("Setting up GPIO Pins for ouput");
		GpioPinDigitalOutput pina = gpio.provisionDigitalOuputPin(RaspiPin.GPIO_05, "Pin A", PinState.LOW);
		GpioPinDigitalOutput pinb = gpio.provisionDigitalOuputPin(RaspiPin.GPIO_06, "Pin B", PinState.LOW);
		GpioPinDigitalOutput pinc = gpio.provisionDigitalOuputPin(RaspiPin.GPIO_10, "Pin C", PinState.LOW);
		GpioPinDigitalOutput pind = gpio.provisionDigitalOuputPin(RaspiPin.GPIO_11, "Pin D", PinState.LOW);


		HashMap driveLogic=new HashMap();

		driveLogic.put(0, "1,0,0,1");
		driveLogic.put(1, "0,0,0,1");
		driveLogic.put(2, "0,0,1,1");
		driveLogic.put(3, "0,0,1,0");
		driveLogic.put(4, "0,1,1,0");
		driveLogic.put(5, "0,1,0,0");
		driveLogic.put(6, "1,1,0,0");
		driveLogic.put(7, "1,0,0,0");

		System.out.print("Driving motor");
		while (true) {
			for (int i = 1; i < driveLogic.size(); i++) {

				String grayCode = (String) driveLogic.get(i);
				
				if (grayCode.charAt(0) == '0') {

					pina.low();
				} else {

					pina.high();
				}
				if (grayCode.charAt(1) == '0') {

					pinb.low();
				} else {

					pinb.high();
				}
				if (grayCode.charAt(2) == '0') {

					pinc.low();
				} else {

					pinc.high();
				}
				if (grayCode.charAt(3) == '0') {

					pind.low();
				} else {

					pind.high();
				}
				
				try{

				Thread.sleep(10);
				}
				catch(Interrupted Exception){
				}
			}
		}
		

		}

	


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>