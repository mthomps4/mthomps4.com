# Rails Gems for SEO

- Consider using gems like `meta-tags` for managing meta tags easily.
- Gems like `sitemap_generator` can help automate the generation of sitemap.xml files.

## Bucket CDN Cache (S3)

Bucket Cache

```yaml
{
  'Version': '2012-10-17',
  'Statement':
    [
      {
        'Effect': 'Allow',
        'Principal': '*',
        'Action': 's3:GetObject',
        'Resource': 'arn:aws:s3:::your-bucket-name/*',
        'Condition':
          {
            'StringEquals':
              { 's3:ExistingObjectTag/Cache-Control': 'max-age=3600' },
          },
      },
    ],
}
```
