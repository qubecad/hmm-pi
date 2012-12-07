/*
 * 
 * Example of a Stepper Motor Control for the Raspberry Pi.
 * 
 * Based on an example by Matt Hawkins
 * 
 */






package com.qubecad.pi.stepper;

import java.util.HashMap;

import com.pi4j.io.gpio.GpioController;
import com.pi4j.io.gpio.GpioFactory;
import com.pi4j.io.gpio.GpioPinDigitalOutput;
import com.pi4j.io.gpio.PinState;
import com.pi4j.io.gpio.RaspiPin;

public class PiStepper {

	/**
	 * 
	 * Driving a Stepper Motor From Java 
	 * 
	 * @param args
	 * @throws InterruptedException 
	 */
	public static void main(String[] args) throws InterruptedException {


		// create gpio controller
		GpioController gpio = GpioFactory.getInstance();

		// Set up the pins and set low to start
		System.out.print("Setting up GPIO Pins for ouput");
		GpioPinDigitalOutput pina = gpio.provisionDigitalOuputPin(RaspiPin.GPIO_05, "Pin A", PinState.LOW);
		GpioPinDigitalOutput pinb = gpio.provisionDigitalOuputPin(RaspiPin.GPIO_06, "Pin B", PinState.LOW);
		GpioPinDigitalOutput pinc = gpio.provisionDigitalOuputPin(RaspiPin.GPIO_10, "Pin C", PinState.LOW);
		GpioPinDigitalOutput pind = gpio.provisionDigitalOuputPin(RaspiPin.GPIO_11, "Pin D", PinState.LOW);


		HashMap<Integer, String> driveLogic=new HashMap<Integer, String>();

		driveLogic.put(0, "1001");
		driveLogic.put(1, "0001");
		driveLogic.put(2, "0011");
		driveLogic.put(3, "0010");
		driveLogic.put(4, "0110");
		driveLogic.put(5, "0100");
		driveLogic.put(6, "1100");
		driveLogic.put(7, "1000");

		System.out.print("Driving motor");
		while (true) {
			for (int i = 1; i < driveLogic.size(); i++) {

				String grayCode = (String) driveLogic.get(i);
				setPin(pina,grayCode.charAt(0));
				setPin(pinb,grayCode.charAt(1));
				setPin(pinc,grayCode.charAt(2));
				setPin(pind,grayCode.charAt(3));

				Thread.sleep(10);
			}
		}

	}

	/**
	 * 
	 * Sets the passed pin Low or High depending on the passed value.
	 * 
	 * @param pin
	 * @param value
	 */
	private static void setPin(GpioPinDigitalOutput pin,char value){
		if (value == '0') {

			pin.low();
		} else {

			pin.high();
		}
	}

}
