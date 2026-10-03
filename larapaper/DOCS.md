# LaraPaper

## Setup

1. Set `app_url` to the address your TRMNL device will use to reach this add-on, e.g. `http://192.168.1.10:8080`.
2. Set your `app_timezone` (e.g. `America/New_York`). Full list at [php.net/timezones](https://www.php.net/manual/en/timezones.php).
3. Start the add-on.
4. Open the web UI at the same address (the "Open Web UI" button) and complete first-time setup. The add-on does not use Home Assistant ingress: LaraPaper needs to run at the root of its own address.

## Pointing your TRMNL device at this add-on

During device provisioning (Wi-Fi setup screen), set **Server URL** to the same value as `app_url`. The device will appear automatically in the LaraPaper device list.

## Configuration

| Option | Description | Default |
|--------|-------------|---------|
| `app_url` | URL the TRMNL device uses to reach this add-on | `http://homeassistant.local:8080` |
| `app_timezone` | Timezone for display timestamps | `UTC` |
| `registration_enabled` | Allow new user registration via the web UI | `true` |
| `log_level` | Log verbosity (`debug`, `info`, `warning`, `error`) | `warning` |
| `php_memory_limit` | Memory limit per PHP worker | `512M` |
| `php_fpm_pm_max_children` | Max concurrent PHP workers (= max concurrent Chromium render processes) | `4` |
| `php_fpm_pm_max_spare_servers` | Max idle PHP workers kept warm | `2` |
| `trmnl_proxy_base_url` | Base URL for TRMNL cloud proxy mode | `https://trmnl.app` |
| `trmnl_proxy_refresh_minutes` | How often to fetch images from the cloud proxy | `15` |

## Migrating from another LaraPaper server

1. Stop the add-on.
2. Copy the old server's `database.sqlite` into the add-on config folder (`/addon_configs/<slug>/`, e.g. via the Samba share), replacing the existing file.
3. Put the old server's `APP_KEY` value (`base64:...`) in a file named `app_key` in the same folder.
4. Start the add-on. The key is imported into private storage and the `app_key` file is deleted.

## Persistent data

The add-on stores all data in `/addon_configs/larapaper/` on the host:

- `database.sqlite` — devices, plugins, recipes, schedules
- `app_key` — Laravel encryption key (auto-generated on first start)

Both survive add-on updates and restarts.

## Updates

When a new version is available, HA will show an update notification in the add-on store. The database and app key are preserved across updates.
