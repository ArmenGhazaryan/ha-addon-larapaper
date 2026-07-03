# LaraPaper

## Setup

1. Set `app_url` to the address your TRMNL device will use to reach this add-on, e.g. `http://192.168.1.10:4567`.
2. Set your `app_timezone` (e.g. `America/New_York`). Full list at [php.net/timezones](https://www.php.net/manual/en/timezones.php).
3. Start the add-on.
4. Open the web UI at the same address and complete first-time setup.

## Pointing your TRMNL device at this add-on

During device provisioning (Wi-Fi setup screen), set **Server URL** to the same value as `app_url`. The device will appear automatically in the LaraPaper device list.

## Configuration

| Option | Description | Default |
|--------|-------------|---------|
| `app_url` | URL the TRMNL device uses to reach this add-on | `http://homeassistant.local:4567` |
| `app_timezone` | Timezone for display timestamps | `UTC` |
| `registration_enabled` | Allow new user registration via the web UI | `true` |
| `log_level` | Log verbosity (`debug`, `info`, `warning`, `error`) | `warning` |
| `php_memory_limit` | Memory limit per PHP worker | `512M` |
| `php_fpm_pm_max_children` | Max concurrent PHP workers (= max concurrent Chromium render processes) | `4` |
| `php_fpm_pm_max_spare_servers` | Max idle PHP workers kept warm | `2` |
| `trmnl_proxy_base_url` | Base URL for TRMNL cloud proxy mode | `https://trmnl.app` |
| `trmnl_proxy_refresh_minutes` | How often to fetch images from the cloud proxy | `15` |

## Persistent data

The add-on stores all data in `/addon_configs/larapaper/` on the host:

- `database.sqlite` — devices, plugins, recipes, schedules
- `app_key` — Laravel encryption key (auto-generated on first start)

Both survive add-on updates and restarts.

## Updates

When a new version is available, HA will show an update notification in the add-on store. The database and app key are preserved across updates.
