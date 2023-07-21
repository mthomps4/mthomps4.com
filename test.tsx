import * as React from 'react';
import { DetailedHTMLProps, ButtonHTMLAttributes } from 'react';
import { VariantProps, cva } from 'class-variance-authority';

import { cn } from '@/lib/style';

const baseStyles =
  'font-brandon inline-flex items-center justify-center transition-colors focus:outline-none focus:ring-2 focus:ring-slate-400 focus:ring-offset-2 disabled:pointer-events-none rounded-md uppercase font-bold';

const variantStyles = {
  variant: {
    primary:
      'bg-black text-white hover:text-brand-primary-300 disabled:bg-brand-inactive-400 disabled:text-brand-white-300 disabled:cursor-not-allowed',
    secondary:
      'bg-white text-black border border-solid border-black hover:border-brand-primary-700 hover:text-brand-primary-700 hover:bg-brand-primary-300 disabled:text-brand-inactive-400 disabled:border-brand-inactive-400',
  },
  state: {
    error: 'border-solid border-2 border-brand-alert-500 cursor-not-allowed',
  },
  size: {
    desktop: 'py-[15px] px-[20px] text-lg',
    mobile: 'py-[15px] px-[20px] text-md',
  },
};

const primaryErrorStyles = 'bg-brand-inactive-400 text-brand-white-300 hover:text-brand-white-300';

const secondaryErrorStyles =
  'text-brand-alert-500 hover:bg-white hover:text-brand-alert-500 hover:border-brand-alert-500';

const buttonVariants = cva(baseStyles, {
  variants: variantStyles,
  defaultVariants: {
    variant: 'primary',
    size: 'desktop',
  },
  compoundVariants: [
    {
      variant: 'primary',
      state: 'error',
      class: primaryErrorStyles,
    },
    {
      variant: 'secondary',
      state: 'error',
      class: secondaryErrorStyles,
    },
  ],
});

export interface ButtonProps
  extends DetailedHTMLProps<ButtonHTMLAttributes<HTMLButtonElement>, HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, state, ...props }, ref) => {
    return (
      <button
        className={cn(buttonVariants({ variant, size, state, className }))}
        ref={ref}
        {...props}
      />
    );
  }
);

Button.displayName = 'Button';

export { Button, buttonVariants };
