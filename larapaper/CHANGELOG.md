## 1.0.17

- Friendly option names and descriptions in the Configuration tab
- Advanced options (PHP workers, memory, cloud proxy) are now optional with sensible defaults; set them under "Show unused optional configuration options"
- Pin LaraPaper to a specific upstream release (0.43.1); a scheduled GitHub workflow bumps it when upstream publishes a new release
- Remove the "Open Web UI" button (it pointed at the Home Assistant host name over HTTPS, which LaraPaper does not serve)

## 1.0.16

- Disable Home Assistant ingress: LaraPaper builds absolute asset URLs and does not support running under the ingress sub-path, so the page loaded without CSS/JS. Open the web UI on port 8080 instead ("Open Web UI" button) and set `app_url` to that address
- One-time APP_KEY import: place an existing key in the add-on config folder as `app_key`; it is moved to `/data/app_key` on start and the file is removed

## 1.0.0

- Initial release
- Supports aarch64 and amd64
- Persistent SQLite database and APP_KEY in `/data`
- Configurable PHP-FPM pool, memory limit, timezone, log level, and TRMNL proxy settings
