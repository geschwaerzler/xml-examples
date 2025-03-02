package at.fhv.brewrecipes;

import java.io.File;
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

import at.fhv.brewrecipes.model.BrewRecipes;

public class BrewRecipes2Json {

	public static void main(String[] args) {

		CommandLineParser cli = new DefaultParser();
		Options options = new Options();
		options.addOption("o", true, "output file in JSON format");
		
		try {
			CommandLine cmd = cli.parse(options, args);
			if (cmd.getArgs().length != 1) {
				HelpFormatter formatter = new HelpFormatter();
				formatter.printHelp("Xml2Json [-o <file>] <file>", options);
				return;
			}
			String inPath = cmd.getArgs()[0];
			OutputStreamWriter out = new OutputStreamWriter(System.out);
			if (cmd.hasOption('o')) {
				out = new FileWriter(cmd.getOptionValue('o'));
			}

			XmlMapper mapper = new XmlMapper();
			BrewRecipes recipes = mapper.readValue(new File(inPath), BrewRecipes.class);
			
			ObjectMapper json = new ObjectMapper();
			json.enable(SerializationFeature.INDENT_OUTPUT);
			json.writeValue(out, recipes);
			out.close();
			
		} catch (ParseException e) {
			System.err.println("Parsing options failed: " + e.getMessage());
		} catch (IOException e) {
			System.err.println(e.getMessage());
			e.printStackTrace();
		}
	}
	
}
