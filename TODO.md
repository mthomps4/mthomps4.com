# TODOs

## Home Screen

- Rework Headshot

## Digital Forge

- About the blog text
- Placeholder Feature Image when non present

## Hand Tool Armory

- Content... Check the leading paragraphs

## Connect

- Email me @mthomps4

## Nice to Have

- Cleanup/Round out Theming and styles @apply and helpers

## Resumes

- Needs CRUD (or missing Create)
- Needs "Mark as Active" or similar
  - Leverage in Connect tab

## Pre Launch

- Optimize Images
- Posthog (optional/cost?)
- Cleanup S3
- Data to Production
- DNS Swap

## Rails Gems for SEO

- Consider using gems like `meta-tags` for managing meta tags easily.
- Gems like `sitemap_generator` can help automate the generation of sitemap.xml files.

### Bucket CDN Cache (S3)

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

## Warnings

WARNING: Detected running cluster mode with 1 worker.

[7] ! Running Puma in cluster mode with a single worker is often a misconfiguration.

[7] ! Consider running Puma in single-mode (workers = 0) in order to reduce memory overhead.

[7] ! Set the `silence_single_worker_warning` option to silence this warning message.
