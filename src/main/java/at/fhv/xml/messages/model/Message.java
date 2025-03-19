package at.fhv.xml.messages.model;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;

public class Message {

	@JacksonXmlProperty(isAttribute = true)
	public String from;

	@JacksonXmlProperty(isAttribute = true)
	public String to;
	
	public String subject;
	
	@JacksonXmlElementWrapper(localName = "cc-adresses")
	@JacksonXmlProperty(localName = "cc")
	public List<String> ccAddresses;
	
	public String text;
	
	public Message(String from, String to, String subject, String text) {
		super();
		this.from = from;
		this.to = to;
		this.subject = subject;
		this.text = text;
		this.ccAddresses = new ArrayList<String>();
	}
	
}
