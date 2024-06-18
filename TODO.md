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
