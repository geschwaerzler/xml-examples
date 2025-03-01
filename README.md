# xml-examples
This repo extends the eclipse demo-project "XMLExamples" with some examples that I develop during the lecture and lab of my course "Datamanagement with XML" held at FH Vorarlberg. The eclipse project has been renamed to "xml-examples" for this purpose.

## Requirements
This repo contains a project for the Eclipse IDE, hence, you will need a running Eclipse installation. I strongly recommend a recent **Eclipse IDE for Enterprise Java and Web Developers**. For me, the easiest way to do that is by using the eclipse installer, which you can download here: [Eclipse Installer](https://www.eclipse.org/downloads/packages/installer).

In order to download this project, or better "git clone" this project, you can use Eclipse's built in git tools.

## Installation
1. (Fork and) clone this repo
  * **If you have a GitHub account**:
    * In GitHub: fork this repo into your personal GitHub account.
    * in Eclipse: open the Git perspective ...  
    ![Tool: Open Perspective][open-perspectives]
    ![Open the Git perspective][open-git-perspective]
    * and clone the SS25 branch. Here is the clone tool:
    ![Open the clone toole][open-clone]
  * If you **don't have a GitHub** account:
    * On your local machine: create a directory outside of your eclipse workspace.
    * Change into that directory and clone the repo e.g. on a bash command line:  
	`git clone https://github.com/geschwaerzler/xml-examples.git`

1. Import the project into eclipse:
  * Select menu "File" > "Import…"
  * in the dialog open folder "General" select "Existing Projects into Workspace" and click button "Next >"
  * use the option "Select root directory"
  * chose the directory "xml-examples", that has been created by the  _git clone_  above and click button "Finish".

[open-perspectives]: readme-img/perspectives-tool.png "The perspective tool"
[open-git-perspective]: readme-img/perspective-selection.png
[open-clone]: readme-img/git-clone-tool.png