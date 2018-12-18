# xml-examples
This repo extends the eclipse demo-project "XMLExamples" with some examples that I develop during the lecture and lab of my course "Datamanagement with XML" held at FH Vorarlberg. The eclipse project has been renamed to "xml-examples" for this purpose.

## Requirements
This repo contains a project for the Eclpise IDE, hence, you will need a running Eclipse installation. I strongly recomment a recent "Eclipse IDE for Java EE Developers", which you can download here: http://www.eclipse.org/ide/ by following the link "Java EE".

In order to download this project, or better "git clone" this project, I recomment a local installation of the git command line tools on your development machine.

## Installation
1. Clone this repo into a directory outside the workspace of your eclipse installation, e.g. on a bash command line:  
   `git clone https://github.com/geschwaerzler/xml-examples.git`
1. Import the project into eclipse:
  * Select menu "File" > "Import…"
  * in the dialog open folder "General" select "Existing Projects into Workspace" and click button "Next >"
  * use the option "Select root directory"
  * chose the directory "xml-examples", that has been created by the _git clone_ above and click button "Finish".

## Update your sources to the latest revision of the GIT repository

Perform a _git pull_ command to get the most recent version of this project merged into your local copy:
* change into the toplevel directory of the project, e.g.  
  `cd ~/Developer/xml-examples/`
* perform the pull command:  
  `git pull`
