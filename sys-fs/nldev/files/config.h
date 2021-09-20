static const Rule rules[] = {
	/* ACTION    SUBSYSTEM      other env variables   command to run */
	{  "add",    NULL,          "DEVNAME",            "/usr/bin/smdev"          },
	{  "remove", NULL,          "DEVNAME",            "/usr/bin/smdev"          },
	{  "add",    NULL,          "MODALIAS",           "/usr/libexec/modprobe_env"   },
	{  "add",    NULL,          NULL,                 "/usr/bin/libudev-zero-helper" },
	{  "remove", NULL,          NULL,                 "/usr/bin/libudev-zero-helper" },
	{  "bind",   NULL,          NULL,                 "/usr/bin/libudev-zero-helper" },
	{  "change", NULL,          NULL,                 "/usr/bin/libudev-zero-helper" },
};
