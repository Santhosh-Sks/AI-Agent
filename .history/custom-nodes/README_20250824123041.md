# Custom Nodes Directory

This directory is for custom n8n nodes. 

To add custom nodes:
1. Place your custom node packages in this directory
2. They will be automatically copied to the container during build

Example structure:
```
custom-nodes/
├── @my-org/
│   └── my-custom-node/
│       ├── package.json
│       └── MyCustomNode.node.js
└── another-custom-node/
    ├── package.json
    └── AnotherNode.node.js
```

For more information about creating custom nodes, visit:
https://docs.n8n.io/integrations/creating-nodes/
