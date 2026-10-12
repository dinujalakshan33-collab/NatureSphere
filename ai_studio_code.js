// tests/i18n.spec.js
const { test, expect } = require('@playwright/test');

test.describe('NatureSphere Internationalization Suite', () => {

  test('Should dynamically flip document to RTL when Arabic is selected', async ({ page }) => {
    await page.goto('http://localhost:3000');
    await page.selectOption('#lang-selector', 'ar');

    const htmlDir = await page.getAttribute('html', 'dir');
    const htmlLang = await page.getAttribute('html', 'lang');

    expect(htmlDir).toBe('rtl');
    expect(htmlLang).toBe('ar');
    await expect(page.locator('#i18n-hero-title')).toContainText('الحيوانات البرية وعجائب الأرض الحية');
  });

  test('Should search and locate taxa using Sinhala unicode script', async ({ page }) => {
    await page.goto('http://localhost:3000');
    await page.selectOption('#lang-selector', 'si');

    // Search for "සිංහයා" (Lion in Sinhala)
    await page.fill('#facet-search', 'සිංහයා');

    const card = page.locator('#specimens-container');
    await expect(card).toContainText('අප්‍රිකානු සිංහයා');
    await expect(card).toContainText('Panthera leo'); // Latin binomial must remain present
  });

  test('Should search and locate taxa using Latin Binomial across any language mode', async ({ page }) => {
    await page.goto('http://localhost:3000');
    await page.selectOption('#lang-selector', 'ta'); // Tamil mode

    // Search for Latin Binomial "Balaenoptera musculus"
    await page.fill('#facet-search', 'Balaenoptera musculus');

    const card = page.locator('#specimens-container');
    await expect(card).toContainText('நீலத் திமிங்கலம்'); // Tamil Blue Whale
  });

  test('Should remember language selection across page reloads', async ({ page }) => {
    await page.goto('http://localhost:3000');
    await page.selectOption('#lang-selector', 'ja');
    await page.reload();

    const selectedVal = await page.inputValue('#lang-selector');
    expect(selectedVal).toBe('ja');
  });

});