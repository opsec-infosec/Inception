#!/bin/bash

/usr/local/bin/code/bin/code-server --install-extension /home/${WP_ADMIN_NAME}/ext/cpptools-linux.vsix
/usr/local/bin/code/bin/code-server --install-extension /home/${WP_ADMIN_NAME}/ext/42header-long-0.43.1_vsixhub.com.vsix
/usr/local/bin/code/bin/code-server --install-extension /home/${WP_ADMIN_NAME}/ext/makefile-tools.vsix
pip3 install importlib-metadata
pip3 install norminette

/usr/local/bin/code/bin/code-server
