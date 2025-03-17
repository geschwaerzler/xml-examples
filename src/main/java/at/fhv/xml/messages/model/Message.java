package at.fhv.xml.messages.model;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

@JacksonXmlRootElement(localName = "message")
public class Message {

	protected String from;
	protected String to;
	protected String subject;
	protected String text;
	
	public Message(String from, String to, String subject, String text) {
		super();
		this.from = from;
		this.to = to;
		this.subject = subject;
		this.text = text;
	}
	
	
	@JacksonXmlProperty(isAttribute = true)	
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	
	@JacksonXmlProperty(isAttribute = true)	
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	
	@JacksonXmlProperty(isAttribute = true)	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	
}
