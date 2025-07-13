# Upload Services Guide

Comprehensive guide to all upload services supported by HyprUpld, including built-in services and custom instances.

## Overview

HyprUpld supports multiple upload services, each with different authentication methods and response formats. Services are categorized into:

- **Built-in Services**: Pre-configured services with known APIs
- **Custom Services**: Self-hosted instances of popular platforms

## Built-in Services

### guns.lol

**Command:** `-guns`

**URL:** `https://guns.lol/api/upload`

**Authentication:** API key required

**Response Format:** JSON with `link` field

**Setup:**
1. Visit [guns.lol](https://guns.lol)
2. Create an account and get your API key
3. Run `hyprupld -guns` and enter your API key when prompted

**Example Response:**
```json
{
  "link": "https://guns.lol/i/abc123.png"
}
```

**Features:**
- Fast upload speeds
- Direct image links
- No file size limits (reasonable)
- Reliable service

### e-z.host

**Command:** `-ez`

**URL:** `https://api.e-z.host/files`

**Authentication:** API key required

**Response Format:** JSON with `imageUrl` field

**Setup:**
1. Visit [e-z.host](https://e-z.host)
2. Register and obtain your API key
3. Run `hyprupld -ez` and enter your API key when prompted

**Example Response:**
```json
{
  "imageUrl": "https://e-z.host/i/def456.png"
}
```

**Features:**
- Simple API
- Good uptime
- Direct image URLs

### fakecri.me

**Command:** `-fakecrime`

**URL:** `https://upload.fakecrime.bio`

**Authentication:** Authorization header required

**Response Format:** Direct URL

**Setup:**
1. Visit [fakecri.me](https://fakecri.me)
2. Get your authorization token
3. Run `hyprupld -fakecrime` and enter your token when prompted

**Example Response:**
```
https://fakecri.me/i/ghi789.png
```

**Features:**
- Direct URL response
- Simple authentication
- Fast uploads

### nest.rip

**Command:** `-nest`

**URL:** `https://nest.rip/api/files/upload`

**Authentication:** Authorization header required

**Response Format:** JSON with `fileURL` field

**Setup:**
1. Visit [nest.rip](https://nest.rip)
2. Obtain your authorization token
3. Run `hyprupld -nest` and enter your token when prompted

**Example Response:**
```json
{
  "fileURL": "https://nest.rip/i/jkl012.png"
}
```

**Features:**
- RESTful API
- JSON responses
- Good documentation

### pixelvault.co

**Command:** `-pixelvault`

**URL:** `https://pixelvault.co`

**Authentication:** Authorization header required

**Response Format:** JSON with `resource` field

**Setup:**
1. Visit [pixelvault.co](https://pixelvault.co)
2. Get your authorization token
3. Run `hyprupld -pixelvault` and enter your token when prompted

**Example Response:**
```json
{
  "resource": "https://pixelvault.co/i/mno345.png"
}
```

**Features:**
- Professional service
- Reliable infrastructure
- Good support

### imgur.com

**Command:** `-imgur`

**URL:** `https://api.imgur.com/3/upload`

**Authentication:** Optional (anonymous upload supported)

**Response Format:** JSON with nested `data.link` field

**Setup:**
```bash
# Anonymous upload (no setup required)
hyprupld -imgur

# With Client-ID (optional, for higher rate limits)
# Get Client-ID from https://api.imgur.com/oauth2/addclient
```

**Example Response:**
```json
{
  "data": {
    "link": "https://i.imgur.com/pqr678.png"
  },
  "success": true
}
```

**Features:**
- No authentication required for basic use
- High rate limits with Client-ID
- Reliable and well-known service
- Good image quality preservation

## Custom Services

### Zipline

**Command:** `-zipline <base_url> <authorization>`

**URL Format:** `<base_url>/api/upload`

**Authentication:** Authorization header

**Setup:**
1. Deploy your own Zipline instance
2. Get your authorization key
3. Use the command with your instance details

**Example:**
```bash
hyprupld -zipline https://my-zipline.com myauthkey
```

**Response Format:** JSON with `files[0].url` field

**Example Response:**
```json
{
  "files": [
    {
      "url": "https://my-zipline.com/i/abc123.png"
    }
  ]
}
```

**Features:**
- Self-hosted solution
- Full control over your data
- Customizable
- Open source

### xBackBone

**Command:** `-xbackbone <base_url> <token>`

**URL Format:** `<base_url>/upload`

**Authentication:** Token header

**Setup:**
1. Deploy your own xBackBone instance
2. Configure your token
3. Use the command with your instance details

**Example:**
```bash
hyprupld -xbackbone https://my-xbackbone.com mytoken
```

**Response Format:** JSON with `url` field

**Example Response:**
```json
{
  "url": "https://my-xbackbone.com/i/def456.png"
}
```

**Features:**
- Self-hosted solution
- Privacy-focused
- Customizable
- Open source

## Authentication Management

### Storing Credentials

HyprUpld securely stores authentication credentials in `~/.config/hyprupld/settings.json`:

```json
{
  "guns_auth": "your_guns_api_key",
  "ez_auth": "your_ez_api_key",
  "fakecrime_auth": "your_fakecrime_token",
  "nest_auth": "your_nest_token",
  "pixelvault_auth": "your_pixelvault_token"
}
```

### Security

- Credentials are stored in user-readable JSON format
- File permissions are set to user-only access
- No credentials are logged in debug mode
- Use `-reset` to clear all stored credentials

### First-Time Setup

When you use a service for the first time:

1. HyprUpld detects no saved credentials
2. Opens a GUI dialog asking for your API key/token
3. Saves the credentials for future use
4. Proceeds with the upload

## Service Comparison

| Service | Auth Required | Response Type | Self-Hosted | Rate Limits |
|---------|---------------|---------------|-------------|-------------|
| guns.lol | Yes | JSON | No | Unknown |
| e-z.host | Yes | JSON | No | Unknown |
| fakecri.me | Yes | Direct URL | No | Unknown |
| nest.rip | Yes | JSON | No | Unknown |
| pixelvault.co | Yes | JSON | No | Unknown |
| imgur.com | No | JSON | No | High (with Client-ID) |
| Zipline | Yes | JSON | Yes | Configurable |
| xBackBone | Yes | JSON | Yes | Configurable |

## Troubleshooting Upload Services

### Common Issues

#### Authentication Errors
```bash
# Check if credentials are saved
cat ~/.config/hyprupld/settings.json

# Reset credentials for a service
hyprupld -reset
```

#### Network Errors
```bash
# Test connectivity
curl -I https://guns.lol/api/upload

# Check with debug mode
hyprupld -debug -guns
```

#### Rate Limiting
- Some services have rate limits
- Use debug mode to see rate limit responses
- Consider using imgur with Client-ID for higher limits

### Debug Information

Enable debug mode to see detailed upload information:

```bash
hyprupld -debug -[service_name]
```

Debug output includes:
- Request headers
- Response status codes
- Response body
- Error messages
- Network timing

### Service Status

Check if a service is available:

```bash
# Test service endpoint
curl -I [service_url]

# Test with authentication
curl -H "Authorization: your_token" [service_url]
```

## Best Practices

### Choosing a Service

1. **Privacy**: Use self-hosted services (Zipline, xBackBone) for sensitive images
2. **Reliability**: Use established services (imgur, guns.lol) for important uploads
3. **Speed**: Test different services for your location
4. **Features**: Consider if you need direct links, galleries, or other features

### Security

1. **API Keys**: Keep your API keys secure and don't share them
2. **Self-Hosted**: Use HTTPS for self-hosted instances
3. **Regular Updates**: Update self-hosted instances regularly
4. **Backup**: Keep backups of your configuration

### Performance

1. **Image Optimization**: Consider image size and format
2. **Network**: Use services with good connectivity to your location
3. **Caching**: Some services cache images for faster access
4. **CDN**: Services with CDN provide faster global access

## Adding New Services

To add support for a new service, you would need to:

1. **Understand the API**: Research the service's upload API
2. **Authentication**: Determine the authentication method
3. **Response Format**: Understand the response structure
4. **Error Handling**: Handle various error conditions
5. **Testing**: Test with various image types and sizes

### Service Requirements

A service should have:
- HTTP/HTTPS upload endpoint
- Support for multipart/form-data
- JSON or direct URL response
- Reasonable rate limits
- Good uptime

## Examples

### Basic Usage
```bash
# Upload to imgur (no auth required)
hyprupld -imgur

# Upload to guns.lol (auth required)
hyprupld -guns

# Upload to custom Zipline
hyprupld -zipline https://my-zipline.com mykey
```

### Advanced Usage
```bash
# Debug mode with service
hyprupld -debug -imgur

# Silent upload
hyprupld -silent -guns

# Save and upload
hyprupld -s -imgur
```

### Service-Specific Examples
```bash
# imgur with debug
hyprupld -debug -imgur

# guns.lol with save
hyprupld -guns -s

# Custom Zipline with mute
hyprupld -zipline https://example.com key -mute
```

## Support

For issues with specific services:

1. **Check service status**: Visit the service's status page
2. **Verify credentials**: Ensure your API keys are correct
3. **Test manually**: Try uploading via curl or the service's web interface
4. **Check logs**: Use debug mode to see detailed error information
5. **Contact service**: Reach out to the service's support if needed

---

**Note**: Service availability and features may change over time. Always check the service's documentation for the most up-to-date information. 