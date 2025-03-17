package at.fhv.xml.messages;

import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.fasterxml.jackson.dataformat.xml.ser.ToXmlGenerator;

import at.fhv.xml.messages.model.Message;

public class MessageTool {

	public static void main(String[] args) {

		CommandLineParser cli = new DefaultParser();
		Options options = new Options();
		options.addOption("t", true, "format type: json | xml (default)");
		options.addOption("o", true, "output file in JSON or XML format");
		options.addOption("h", false, "help");
		
		try {
			CommandLine cmd = cli.parse(options, args);
			if (cmd.getArgs().length != 0 || cmd.hasOption('h')) {
				HelpFormatter formatter = new HelpFormatter();
				formatter.printHelp("MessageTool [-t <type>] [-o <file>] [-h]", options);
				return;
			}
			
			OutputStreamWriter out = new OutputStreamWriter(System.out);
			if (cmd.hasOption('o')) {
				out = new FileWriter(cmd.getOptionValue('o'));
			}

			if (cmd.hasOption('t') && cmd.getOptionValue('t').equals("json")) {
				ObjectMapper json = new ObjectMapper();
				json.enable(SerializationFeature.INDENT_OUTPUT);
				json.writeValue(out, getMessage());
			} else if (! cmd.hasOption('t') || cmd.getOptionValue('t').equals("xml")) {
				XmlMapper xml = new XmlMapper();
				xml.configure(ToXmlGenerator.Feature.WRITE_XML_DECLARATION, true);
				xml.enable(SerializationFeature.INDENT_OUTPUT);
				xml.writeValue(out, getMessage());
			} else {
				throw new ParseException("allowed values for parameter '-t': 'xml' or 'json' ");
			}
			
			out.close();
			
		} catch (ParseException e) {
			System.err.println("Parsing options failed: " + e.getMessage());
		} catch (IOException e) {
			System.err.println(e.getMessage());
			e.printStackTrace();
		}
	}
	
	private static Message getMessage() {
		return new Message(
				"me@myAddress.com",
				"you@yourAddress.com",
				"XML is really cool!",
				"How many ways is XML cool? Let me count the ways...");
		
	}
}
