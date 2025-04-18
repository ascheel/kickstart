package main

import (
	"flag"
	"fmt"
	// "gopkg.in/yaml.v3"
)

type Config struct {
	Git struct {
		Email string		`yaml:"email"`
		Name  string		`yaml:"name"`
		IdentityFile string	`yaml:"identity_file"`
	} `yaml:"git"`
	Apt struct {
		Packages []string	`yaml:"packages"`
	} `yaml:"apt"`
	Move []struct {
		Src string	`yaml:"src"`
		Dst string	`yaml:"dst"`
		User string	`yaml:"user"`
		Group string	`yaml:"group"`
		Mode string `yaml:"mode"`
	} `yaml:"move"`
}

// func (c *Config) Load(filename string) {
// 	// Read the YAML file
// 	var config Config
// 	configFile, err := filepath.Join("kickstart.yml")
// 	if err != nil {
// 		panic(err)
// 	}
// }

func main() {
	var move bool
	flag.BoolVar(&move, "move", false, "Execute 'move' segment")
	flag.Parse()

	var command string
	if len(flag.Args()) > 0 {
		command = flag.Arg(0)
	}

	fmt.Printf("Move: %v\n", move)
	// c = &Config{}
	// err := c.Load("kickstart.yml")
}
