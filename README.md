# Hugo Development Environment

A development environment for Hugo websites using Docker Compose.

## Configuration

Add the following to your ~/.profile to ensure that GROUP_ID and USER_ID are declared for use within Docker Compose.

```bash
export GROUP_ID=$(id -g)
export USER_ID=$(id -u)
```

### expose Target

The expose target makes use of a tool called ngrok to provide a temporary ingress to the local instance of the site created by Docker Compose.

You'll need to create a free account at [ngrok](https://ngrok.com/) to use the expose target. Ensure the following have been included in ~/.profile.

```bash
export NGROK_AUTHTOKEN=<YOUR NGROK AUTHTOKEN>
export NGROK_URL=<YOUR NGROK URL>
```

## Usage

### From Scratch

All of the following commands should be run using the cli interface provided by the cli makefile rule.  Start the cli tool up by running: `make cli`

```bash
# Create a new site
hugo new site . --format yaml

# Initialise git as SCM for site
git init .

# Install and configure the eclectic theme
git submodule add https://github.com/hugoinaction/Eclectic.git themes/eclectic
echo 'theme: eclectic' >> config.yaml

# Quit out of the CLI tool
exit
```

Start the Hugo server by running `make up`

The site should be available at <http://localhost:1313>

Stop the Hugo server by running `make down`
