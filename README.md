# create a jakarta ee/microprofile project in seconds

## installation
1. clone this repo
2. in .bashrc or .zshrc define an alias i.e. <br>
<code>alias setupJakartaeeProject=~/scripts/jakartaee-starter/setupJakartaeeProject.sh</code><br>
or add the script to your PATH variable.
3. call the script with a project name:<br>
<code>$ setupJakartaeeProject myProject</code>
4. within the newly created project:
<code>$ mvn package</code>