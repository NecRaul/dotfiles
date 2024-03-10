rule1 = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.pci-0000_06*" },
    },
  },
  apply_properties = {
    ["node.description"] = "Speakers",
  },
}


rule2 = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.pci-0000_08*" },
    },
  },
  apply_properties = {
    ["node.description"] = "Headphones",
  },
}

rule3 = {
  matches = {
    {
      { "node.name", "matches", "alsa_input.pci-0000_08*" },
    },
  },
  apply_properties = {
    ["node.description"] = "Microphone",
  },
}

table.insert(alsa_monitor.rules, rule1)
table.insert(alsa_monitor.rules, rule2)
table.insert(alsa_monitor.rules, rule3)
